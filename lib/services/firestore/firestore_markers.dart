import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:spots/flows/menu/data/models/marker_point_model.dart';

@injectable
class FirestoreMarkers {
  FirestoreMarkers(this.firebaseFirestore)
      : _markersCollection = firebaseFirestore.collection('markers');

  final FirebaseFirestore firebaseFirestore;

  final CollectionReference<Map<String, dynamic>> _markersCollection;

  Future<List<MarkerPointModel>> getMarkerPoints() async {
    final result = await _markersCollection.get();
    final markersFutures = result.docs.map((doc) async {
      final DocumentReference chatRef = doc.get('chatRef');
      final chatDoc = await chatRef.get();
      final GeoPoint geoPoint = doc.get('geopoint');

      return MarkerPointModel(
        id: doc.id,
        name: chatDoc.get('title'),
        description: chatDoc.get('description'),
        latitude: geoPoint.latitude,
        longitude: geoPoint.longitude,
      );
    }).toList();
    final markerPoints = await Future.wait(markersFutures);
    
    return markerPoints;
  }
}
