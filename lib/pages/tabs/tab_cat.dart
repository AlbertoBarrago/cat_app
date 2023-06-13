import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TabCat extends StatefulWidget {
  const TabCat({super.key, required this.title});

  final String title;

  @override
  State<TabCat> createState() => _CatGridWidgetState();
}

class _CatGridWidgetState extends State<TabCat> {
  late Future<List<String>> _catImagesFuture = Future.value([]);

  @override
  void initState() {
    super.initState();
    _fetchCatImages();
  }

  Future<void> _fetchCatImages() async {
    final response = await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final catImages = data.map((item) => item['url'] as String).toList();
      setState(() {
        _catImagesFuture = Future.value(catImages);
      });
    } else {
      setState(() {
        _catImagesFuture = Future.error('Failed to fetch cat images.');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: _catImagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final catImages = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: catImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle image tap
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          catImages[index],
                          fit: BoxFit.cover,
                        ),
                        const Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
