import 'dart:convert';
import 'dart:math';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


class TabCat extends StatefulWidget {
  const TabCat({super.key});

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
    final response = await http.get(Uri.parse('https://api.thecatapi.com/v1/images/search?limit=20'));
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

  String createRandomTitleFunnyTitle() {
    final random = Random();
    final funnyTitles
    = ['Funny Cat', 'Cute Cat', 'Crazy Cat', 'Angry Cat', 'Sleepy Cat', 'Hungry Cat', 'Silly Cat', 'Lazy Cat', 'Cuddly Cat', 'Happy Cat', 'Sneaky Cat', 'Sassy Cat', 'Grumpy Cat', 'Fluffy Cat'];
    final randomIndex = random.nextInt(funnyTitles.length);
    final randomTitle = funnyTitles[randomIndex];
    return randomTitle;
  }

  void _showImageModal(String imageUrl, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                title: Text(title),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      shareImage(imageUrl);
                    },
                  ),
                  IconButton(
                      icon: const Icon(Icons.download),
                       onPressed: () {
                        downloadImage(imageUrl, 'cat');
                       }
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.photo),
                  //   onPressed: () {
                  //     takePhoto('cat');
                  //   },
                  // )
                ],
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: FractionallySizedBox(
                  heightFactor: 1,
                  child: PhotoViewGallery(
                    pageOptions: [
                      PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(imageUrl),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered,
                        initialScale: PhotoViewComputedScale.covered,
                      ),
                    ],
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    loadingBuilder: (context, event) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    onPageChanged: (index) {},
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _fetchCatImages,
        child: FutureBuilder<List<String>>(
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
                      _showImageModal(catImages[index], createRandomTitleFunnyTitle());
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
                                Icons.pets,
                                color: Colors.white,
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
      ),
    );
  }

  void shareImage(String imageUrl) {
    Share.share(imageUrl, subject: 'Look at this cat!');
  }

  void downloadImage(String imageUrl, String albumName)  {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
     GallerySaver.saveImage(imageUrl).then((value) =>
     scaffoldMessenger.showSnackBar(
         SnackBar(content: Text('Image saved to $albumName album.')))
     );
  }

}
