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
    // Filtrage des studios selon le nom et le style sélectionné
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedStyle,
              onChanged: (newValue) {
                setState(() {
                  selectedStyle = newValue!;
                });
              },
              items: styles.map((style) {
                return DropdownMenuItem<String>(
                  value: style,
                  child: Text(style[0].toUpperCase() + style.substring(1)),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudios.length,
              itemBuilder: (context, index) {
                final studio = filteredStudios[index];
                return ListTile(
                  title: Text(studio['name']),
                  subtitle: Text(studio['address']),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudioInfoPage(studioIndex: studios.indexOf(studio)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

