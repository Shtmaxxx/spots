import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spots/flows/menu/presentation/pages/spots_map/cubit/map_cubit.dart';
import 'package:spots/services/injectible/injectible_init.dart';
import 'package:spots/widgets/circular_loading.dart';

class SpotsMapPage extends StatelessWidget {
  const SpotsMapPage({
    this.focusedPlaceId,
    super.key,
  });

  final String? focusedPlaceId;

  static const String path = '/spots_map';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MapCubit>()..initMapData(focusedPlaceId),
      child: Builder(
        builder: (context) {
          final mapCubit = context.read<MapCubit>();

          return BlocListener<MapCubit, MapState>(
            listener: (context, state) {
              if (state is MarkerPressed) {
                // showDialog(
                //   context: context,
                //   builder: (context) => MarkerInfoPopUp(
                //     title: state.pressedMarkerPoint.name,
                //     description: state.pressedMarkerPoint.description,
                //     typeName: state.pressedMarkerPoint.type.name,
                //     typeColor: state.pressedMarkerPoint.type.color,
                //     onClosed: () {
                //       Routemaster.of(context).pop();
                //     },
                //   ),
                // );
                // mapCubit.resetMap();
              } else if (state is MapError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.failure.message)),
                );
              }
            },
            child: BlocBuilder<MapCubit, MapState>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Spots Map'),
                  ),
                  body: Builder(
                    builder: (context) {
                      if (state is! Loading) {
                        return Stack(
                          children: [
                            GoogleMap(
                              initialCameraPosition:
                                  state.initialCameraPosition,
                              onMapCreated: mapCubit.onMapCreated,
                              zoomControlsEnabled: false,
                              markers: state.markers,
                              mapToolbarEnabled: false,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                            ),
                          ],
                        );
                      }
                      return const CircularLoading();
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
