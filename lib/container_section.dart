import 'package:flutter/material.dart';
import '/gallery_screen.dart';

class ContainerSection extends StatefulWidget {
  final List<String>? imageUrls;
  ContainerSection({
    required this.imageUrls,
  });
  @override
  State<ContainerSection> createState() => _ContainerSectionState();
}

class _ContainerSectionState extends State<ContainerSection> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: 'winnie hero',
              child: AnimatedContainer(
                height: show ? 100 : 0,
                width: 100,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: ClipOval(child: Image.network(widget.imageUrls![0])),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    child: const Text('Show BIGGER Winnie'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GalleryScreen(
                            widget.imageUrls,
                            heroTag: 'winnie hero',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
