import 'package:flutter/material.dart';
import 'package:mimiqit/data/studio_data.dart';
import 'map_page.dart';

class StudioInfoPage extends StatelessWidget {
  final int studioIndex;

  const StudioInfoPage({required this.studioIndex, super.key});

  @override
  Widget build(BuildContext context) {
    final studio = studios[studioIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Studio Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec le nom du studio
          Container(
            color: Colors.blue,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              studio['name'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Informations générales
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.redAccent),
                    title: Text(studio['address']),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.style, color: Colors.green),
                    title: Text(
                      'Style: ${studio['style'][0].toUpperCase() + studio['style'].substring(1)}',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  studio['description'],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          // Bouton pour voir sur la carte
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(
                      centerPosition: studio['latLng'],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.map),
              label: const Text('View on Map'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
