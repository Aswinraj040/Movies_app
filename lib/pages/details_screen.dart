// details_screen.dart

import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String language;
  final String genres;
  final String status;
  final String runtime;
  final String premiered;
  final String rating;
  final String summary;

  const DetailsScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.language,
    required this.genres,
    required this.status,
    required this.runtime,
    required this.premiered,
    required this.rating,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Movie Image
            if (imageUrl.isNotEmpty)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            // Movie Title
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Language
            Text('Language: $language', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            // Genres
            Text('Genres: $genres', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            // Status
            Text('Status: $status', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            // Runtime
            Text('Runtime: $runtime minutes', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            // Premiered Date
            Text('Premiered: $premiered', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            // Rating
            Text('Rating: $rating', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            // Summary
            Text(
              summary.replaceAll(RegExp(r'<[^>]*>'), ''), // Remove HTML tags
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
