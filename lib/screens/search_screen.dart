import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Simulating real data with subtitles for a better look
  final List<Map<String, String>> _allData = List.generate(
    20,
        (index) => {
      'title': 'Design Project ${index + 1}',
      'subtitle': 'Updated ${index + 2} hours ago',
    },
  );

  List<Map<String, String>> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _filteredData = _allData;
  }

  void _filter(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredData = _allData;
      } else {
        _filteredData = _allData
            .where((item) =>
            item['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Modern Dark Background
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Search", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // 2. Modern Search Bar Container
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D44), // Slightly lighter than bg
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              onChanged: _filter,
              style: const TextStyle(color: Colors.white), // Typing text color
              decoration: InputDecoration(
                hintText: 'Search items...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              cursorColor: Colors.blueAccent,
            ),
          ),

          const SizedBox(height: 10),

          // 3. Results List
          Expanded(
            child: _filteredData.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredData.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final item = _filteredData[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D44),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.folder_open, color: Colors.blueAccent),
                    ),
                    title: Text(
                      item['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      item['subtitle']!,
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.grey[600]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 4. Empty State Widget (Visual feedback when no results)
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey[700]),
          const SizedBox(height: 16),
          const Text(
            'No results found',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching for something else',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
