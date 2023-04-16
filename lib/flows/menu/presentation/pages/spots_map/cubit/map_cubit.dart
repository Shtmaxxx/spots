import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:spots/domain/core/usecase/usecase.dart';
import 'package:spots/flows/menu/domain/entities/marker_point.dart';
import 'package:spots/flows/menu/domain/usecases/get_markers.dart';
import 'package:spots/flows/menu/presentation/pages/spots_map/enums/markers_icons.dart';
import 'package:spots/flows/menu/presentation/pages/spots_map/helpers/location_permissions_helper.dart';
import 'package:spots/flows/menu/presentation/pages/spots_map/helpers/marker_helper.dart';

part 'map_state.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  MapCubit({
    required this.getMarkers,
  }) : super(const Loading());

  final GetMarkersUseCase getMarkers;

  static const CameraPosition defaultInitialCameraPosition = CameraPosition(
    target: LatLng(50.448899667450405, 30.456975575830512),
    zoom: 15,
  );

  late final GoogleMapController controller;
  late Map<MarkersIcons, Uint8List> markersIcons;

  Future<void> initMapData(String? focusedPlaceId) async {
    markersIcons = await MarkerHelper.initMarkersIcons();
    await LocationPermissionsHelper.requestLocationPermissions();
    await loadMapData(focusedPlaceId);
  }

  Future<void> loadMapData([String? focusedPlaceId]) async {
    final result = await getMarkers(NoParams());
    result.fold(
      (failure) {
        emit(
          MapError(
            markers: state.markers,
            markerPoints: state.markerPoints,
            failure: failure,
          ),
        );
      },
      (markerPoints) async {
        CameraPosition? initialCameraPosition;
        if (focusedPlaceId != null) {
          final markerPoint =
              markerPoints.firstWhereOrNull((m) => m.id == focusedPlaceId);
          if (markerPoint != null) {
            final lat = markerPoint.latitude;
            final lon = markerPoint.longitude;
            initialCameraPosition = CameraPosition(
              target: LatLng(lat, lon),
              zoom: 16,
            );
          }
        }
        await displayMarkers(
          markerPoints,
          initialCameraPosition: initialCameraPosition,
        );
      },
    );
  }

  Future<void> displayMarkers(List<MarkerPoint> markerPoints,
      {CameraPosition? initialCameraPosition}) async {
    final markers = markerPoints
        .map(
          (m) => Marker(
            markerId: MarkerId(m.id),
            position: LatLng(m.latitude, m.longitude),
            icon: BitmapDescriptor.fromBytes(markersIcons[MarkersIcons.spot]!),
            onTap: () => _onMarkerPressed(m.id),
          ),
        )
        .toSet();

    emit(
      MapDataLoaded(
        markers: markers,
        markerPoints: markerPoints,
        initialCameraPosition:
            initialCameraPosition ?? defaultInitialCameraPosition,
      ),
    );
  }

  void onMapCreated(GoogleMapController mapController) {
    controller = mapController;
  }

  void _onMarkerPressed(String id) {
    final pressedMarkerPoint =
        state.markerPoints.firstWhereOrNull((m) => m.id == id);

    if (pressedMarkerPoint != null) {
      emit(
        MarkerPressed(
          markers: state.markers,
          markerPoints: state.markerPoints,
          pressedMarkerPoint: pressedMarkerPoint,
        ),
      );
    } else {
      emit(
        MapError(
          markers: state.markers,
          markerPoints: state.markerPoints,
          failure: const OtherFailure(
            message: 'ERROR: Could not find any spot info',
          ),
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    controller.dispose();
    super.close();
  }
}
