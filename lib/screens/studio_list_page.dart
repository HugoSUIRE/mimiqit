import 'package:flutter/material.dart';
import 'package:mimiqit/data/studio_data.dart';
import 'studio_info_page.dart';

class StudioListPage extends StatefulWidget {
  const StudioListPage({super.key});

  @override
  _StudioListPageState createState() => _StudioListPageState();
}

class _StudioListPageState extends State<StudioListPage> {
  String searchQuery = '';
  String selectedStyle = 'All';
  List<String> styles = ['All', 'oriental', 'classic', 'modern', 'ballet', 'salsa'];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredStudios = studios.where((studio) {
      final matchesSearch = studio['name'].toLowerCase().contains(searchQuery.toLowerCase());
      final matchesStyle = selectedStyle == 'All' || studio['style'] == selectedStyle;
      return matchesSearch && matchesStyle;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dance Studios'),
      ),
      body: Column(
        children: [
          // Barre de recherche et filtre
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Search by name',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedStyle,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStyle = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Filter by style',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      ),
                      items: styles.map((style) {
                        return DropdownMenuItem<String>(
                          value: style,
                          child: Text(style[0].toUpperCase() + style.substring(1)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Liste des studios
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudios.length,
              itemBuilder: (context, index) {
                final studio = filteredStudios[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(studio['style'][0].toUpperCase()),
                    ),
                    title: Text(
                      studio['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(studio['address']),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudioInfoPage(
                            studioIndex: studios.indexOf(studio),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
