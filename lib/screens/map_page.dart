import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mimiqit/data/studio_data.dart';
import 'studio_info_page.dart';

class MapPage extends StatelessWidget {
  final LatLng? centerPosition; // Position facultative pour centrer la carte

  const MapPage({this.centerPosition, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dance Studios Map')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: centerPosition ?? LatLng(60.1888852, 24.9776478),
          initialZoom: 9.2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: studios.asMap().entries.map((entry) {
              final index = entry.key;
              final studio = entry.value;

              return Marker(
                point: studio['latLng'],
                width: 50,
                height: 50,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudioInfoPage(studioIndex: index),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.location_pin,
                    size: 50,
                    color: Colors.red,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
