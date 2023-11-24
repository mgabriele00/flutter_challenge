import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/core/constants/app_sizes.dart';
import 'package:flutter_challenge/src/pages/results_page/view/widgets/rounded_network_image.dart';

import 'loading_indicator.dart';

/// A scrollable list of images with lazy loading functionality.
class ImageList extends StatefulWidget {
  /// The list of image URLs to display.
  final List<String> images;

  /// Constructs an [ImageList] widget with the provided [images].
  const ImageList({super.key, required this.images});

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  static const elementsToLoad = 10;
  late int itemsToShow;
  final scrollController = ScrollController();
  bool isAllListLoaded = false;

  @override
  void initState() {
    super.initState();
    if (widget.images.length < elementsToLoad) {
      itemsToShow = widget.images.length;
      setState(() {
        isAllListLoaded = true;
      });
    } else {
      itemsToShow = elementsToLoad;
    }
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) ||
          (scrollController.position.minScrollExtent == 0.0 &&
              scrollController.position.maxScrollExtent == 0)) {
        loadMore();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void loadMore() {
    final offset = widget.images.length - itemsToShow;
    if (offset < elementsToLoad) {
      setState(() {
        itemsToShow = widget.images.length;
        isAllListLoaded = true;
      });
    } else {
      setState(() {
        itemsToShow += elementsToLoad;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p8),
      shrinkWrap: false,
      itemCount: itemsToShow + (isAllListLoaded ? 0 : 1),
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index == itemsToShow && !isAllListLoaded) {
          return const SafeArea(child: LoadingIndicator(topPadding: true));
        }
        final imageUrl = widget.images[index];
        return SafeArea(
          top: false,
          bottom: index == widget.images.length - 1,
          child: RoundedNetworkImage(imageUrl: imageUrl),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return gapH8;
      },
    );
  }
}
