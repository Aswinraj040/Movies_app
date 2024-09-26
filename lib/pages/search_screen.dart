import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/widgets/movie_card.dart';
import 'details_screen.dart'; // Import DetailsScreen for navigation

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> _searchResults = [];
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  Future<void> _fetchSearchResults(String query) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _searchResults = data;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _fetchSearchResults(_searchController.text);
                    }
                  },
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _fetchSearchResults(value);
                }
              },
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty
          ? const Center(child: Text('No results found'))
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.65, // Aspect ratio
        ),
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final movie = _searchResults[index]['show'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    title: movie['name'],
                    imageUrl: movie['image'] != null ? movie['image']['original'] : '',
                    language: movie['language'],
                    genres: movie['genres'].join(', '),
                    status: movie['status'],
                    runtime: movie['runtime'].toString(),
                    premiered: movie['premiered'],
                    rating: movie['rating']['average']?.toString() ?? 'N/A',
                    summary: movie['summary'] ?? 'No summary available',
                  ),
                ),
              );
            },
            child: MovieCard(
              title: movie['name'],
              imageUrl: movie['image'] != null
                  ? movie['image']['medium']
                  : 'https://via.placeholder.com/150', // Fallback image
            ),
          );
        },
      ),
    );
  }
}
