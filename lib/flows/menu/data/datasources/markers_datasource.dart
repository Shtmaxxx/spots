import 'package:injectable/injectable.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:spots/flows/menu/data/models/marker_point_model.dart';
import 'package:spots/services/firestore/firestore_markers.dart';

abstract class MarkersDatasourceI {
  Future<List<MarkerPointModel>> getMarkers();
}

@Injectable(as: MarkersDatasourceI)
class MarkersDatasourceImpl implements MarkersDatasourceI {
  MarkersDatasourceImpl({
    required this.firestoreMarkers,
  });

  final FirestoreMarkers firestoreMarkers;
  
  @override
  Future<List<MarkerPointModel>> getMarkers() async {
    try {
      final result = await firestoreMarkers.getMarkerPoints();
      return result;
    } catch (exception) {
      throw ServerFailure(message: 'Something went wrong: $exception');
    }
  }
}
