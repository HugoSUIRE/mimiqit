import 'package:flutter/material.dart';
import 'package:mimiqit/data/studio_data.dart';
import 'map_page.dart';

class StudioInfoPage extends StatelessWidget {
  final Studio studio;

  const StudioInfoPage({required this.studio, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(studio.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec le nom du studio (design de la branche design)
          Container(
            color: Colors.blue,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              studio.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Informations générales (fonctionnalités de la branche main)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Adresse (fonctionnalité main)
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.redAccent),
                    title: Text(studio.address),
                  ),
                ),
                // Style de danse (fonctionnalité main)
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.style, color: Colors.green),
                    title: Text(
                      'Style: ${studio.style[0].toUpperCase() + studio.style.substring(1)}',
                    ),
                  ),
                ),
                // Description (fonctionnalité main)
                const SizedBox(height: 10),
                Text(
                  studio.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          // Bouton pour voir sur la carte (fonctionnalité main)
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(centerPosition: studio.latLng),
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
