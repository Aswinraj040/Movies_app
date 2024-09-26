// home_screen.dart

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/widgets/movie_card.dart';
import 'details_screen.dart'; // Import the details_screen.dart file

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _movies = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _movies = data;
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'),
      ),
      body: _movies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 10.0, // Horizontal space between grid items
          mainAxisSpacing: 10.0, // Vertical space between grid items
          childAspectRatio: 0.65, // Aspect ratio of each item (width / height)
        ),
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index]['show'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    title: movie['name'],
                    imageUrl: movie['image'] != null ? movie['image']['original'] : '',
                    language: movie['language'] ?? 'Not available',
                    genres: movie['genres'].join(', ') ?? 'Not available',
                    status: movie['status'] ?? 'Not available',
                    runtime: movie['runtime'].toString() ?? 'Not available',
                    premiered: movie['premiered'] ?? 'Not available',
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
