import 'package:flutter/material.dart';

import 'widgets/image_list.dart';

class ResultsListView extends StatelessWidget {
  final List<String> images;
  const ResultsListView({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doggie!')),
      body: ImageList(images: images),
    );
  }
}
