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
  List<String> styles = ['All'];
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

      // Extraire les styles uniques
      final uniqueStyles = {'All'};
      for (var studio in fetchedStudios) {
        uniqueStyles.add(studio.style);
      }

      setState(() {
        studios = fetchedStudios;
        styles = uniqueStyles.toList()
          ..sort(); // Trier les styles par ordre alphabétique
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
    // Filtrage des studios
    List<Studio> filteredStudios = studios.where((studio) {
      final matchesSearch =
          studio.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesStyle =
          selectedStyle == 'All' || studio.style == selectedStyle;
      return matchesSearch && matchesStyle;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dance Studios'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                        child:
                            Text(style[0].toUpperCase() + style.substring(1)),
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
                        title: Text(studio.name),
                        subtitle: Text(studio.address),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudioInfoPage(studio: studio),
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
