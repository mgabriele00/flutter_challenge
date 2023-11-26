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
  double cacheExtent = 0;

  @override
  void initState() {
    super.initState();
    setInitialItemsToShow();
    addScrollListener();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void setInitialItemsToShow() {
    if (widget.images.length < elementsToLoad) {
      itemsToShow = widget.images.length;
      isAllListLoaded = true;
    } else {
      itemsToShow = elementsToLoad;
    }
  }

  void addScrollListener() {
    scrollController.addListener(() {
      if (isAllListLoaded) return;
      //set cacheExtent to total extension to improve list scrolling performance
      adjustCacheExtent();
      //load more items at the end of the list
      loadMoreItems();
    });
  }

  void adjustCacheExtent() {
    if (cacheExtent < scrollController.position.extentTotal) {
      setState(() {
        cacheExtent = scrollController.position.extentTotal;
      });
    }
  }

  void loadMoreItems() {
    if ((scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) ||
        (scrollController.position.minScrollExtent == 0.0 &&
            scrollController.position.maxScrollExtent == 0)) {
      final itemsOffset = widget.images.length - itemsToShow;
      if (itemsOffset < elementsToLoad) {
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
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      cacheExtent: cacheExtent,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p8),
      itemCount: itemsToShow + 1,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index == itemsToShow && !isAllListLoaded) {
          return const SafeArea(
              child: LoadingIndicator(
            topPadding: true,
            key: Key('loadingIndicator'),
          ));
        }
        if (index == itemsToShow && isAllListLoaded) {
          return const SafeArea(
              child: Center(
                  child: Text(
            'You saw all the puppies 🎉',
            key: Key('endingText'),
          )));
        }
        final imageUrl = widget.images[index];
        return RoundedNetworkImage(imageUrl: imageUrl);
      },
      separatorBuilder: (BuildContext context, int index) {
        return gapH8;
      },
    );
  }
}
