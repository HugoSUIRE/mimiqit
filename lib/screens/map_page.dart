import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mimiqit/data/studio_data.dart';
import 'studio_info_page.dart';

class MapPage extends StatefulWidget {
  final LatLng? centerPosition; // Position facultative pour centrer la carte

  const MapPage({this.centerPosition, super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Studio> studios = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudios();
  }

  Future<void> _loadStudios() async {
    try {
      final studioData = StudioData();
      final fetchedStudios = await studioData.fetchStudios();

      setState(() {
        studios = fetchedStudios;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading studios: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dance Studios Map')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter:
                    widget.centerPosition ?? LatLng(60.1888852, 24.9776478),
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: studios.map((studio) {
                    return Marker(
                      point: studio.latLng,
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudioInfoPage(studio: studio),
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
