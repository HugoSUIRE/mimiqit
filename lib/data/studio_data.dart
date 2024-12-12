import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class Studio {
  final String name;
  final String address;
  final LatLng latLng;
  final String description;
  final String style;

  Studio({
    required this.name,
    required this.address,
    required this.latLng,
    required this.description,
    required this.style,
  });

  factory Studio.fromFirestore(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>;
  final geoPoint = data['latLng'] as GeoPoint; // Récupération du GeoPoint
  return Studio(
    name: data['name'],
    address: data['address'],
    latLng: LatLng(geoPoint.latitude, geoPoint.longitude), // Utilisation des propriétés GeoPoint
    description: data['description'],
    style: data['style'],
  );
}
}

class StudioData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Studio>> fetchStudios() async {
    try {
      final querySnapshot = await _firestore.collection('studios').get();
      return querySnapshot.docs.map((doc) => Studio.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching studios: $e');
      rethrow;
    }
  }
}
