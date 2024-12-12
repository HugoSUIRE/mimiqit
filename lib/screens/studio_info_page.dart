import 'package:flutter/material.dart';
import 'package:mimiqit/data/studio_data.dart';
import 'map_page.dart'; // Import de MapPage

class StudioInfoPage extends StatelessWidget {
  final int studioIndex;

  const StudioInfoPage({required this.studioIndex, super.key});

  @override
  Widget build(BuildContext context) {
    final studio = studios[studioIndex];

    return Scaffold(
      appBar: AppBar(title: Text(studio['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              studio['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              studio['address'],
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              'Style: ${studio['style'][0].toUpperCase() + studio['style'].substring(1)}',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            Text(
              studio['description'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20), // Ajouter un espace entre la description et le bouton
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapPage(
                        centerPosition: studio['latLng'], // Position du studio
                      ),
                    ),
                  );
                },
                child: const Text('View on Map'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringCapitalize on String {
  String capitalize() {
    return this[0].toUpperCase() + this.substring(1);
  }
}
