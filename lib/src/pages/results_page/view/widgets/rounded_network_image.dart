import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/core/constants/app_sizes.dart';

/// A widget to display an image loaded from a network and applying a rounded border.
class RoundedNetworkImage extends StatelessWidget {
  /// The URL of the image to be displayed.
  final String imageUrl;

  /// Constructs a [RoundedNetworkImage] widget with the provided [imageUrl].
  const RoundedNetworkImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.fitWidth,
      frameBuilder: (context, child, __, ___) => ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.p12), child: child),
      errorBuilder: (context, _, __) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(AppSizes.p12),
        ),
        child: Center(
          child: Text(
            'Error while loading this picture',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
