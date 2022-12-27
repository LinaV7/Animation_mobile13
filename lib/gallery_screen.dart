import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  final List<String>? imageUrls;
  final String? heroTag;

  const GalleryScreen(this.imageUrls, {Key? key, this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Winnie\'s guests Animations'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: List.generate(
              imageUrls!.length,
              (index) => (heroTag != null && index == 0)
                  ? Card(
                      child: SizedBox(
                        height: 200,
                        child: Hero(
                          tag: heroTag!,
                          child: FadeInImage(
                            placeholder: const AssetImage(
                                'assets/images/placeholder.jpg'),
                            image: NetworkImage(imageUrls![index]),
                          ),
                        ),
                      ),
                    )
                  : Card(
                      child: SizedBox(
                        height: 200,
                        child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/images/placeholder.jpg'),
                          image: NetworkImage(imageUrls![index]),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
