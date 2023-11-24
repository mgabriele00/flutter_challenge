import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/pages/results_page/view/empty_result_view.dart';
import 'package:flutter_challenge/src/pages/results_page/view/results_list_view.dart';
import 'package:flutter_challenge/src/pages/results_page/view/single_result_view.dart';

class ResultsPage extends StatelessWidget {
  final List<String> images;
  final bool isList;

  const ResultsPage({super.key, required this.images, this.isList = true});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const EmptyResultView();
    return isList
        ? ResultsListView(images: images)
        : SingleResultView(imageUrl: images.first);
  }
}
