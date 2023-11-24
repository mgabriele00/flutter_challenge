import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/core/constants/app_sizes.dart';

/// A widget that displays a centered loading indicator with fixed size.
class LoadingIndicator extends StatelessWidget {
  /// Determines whether to add top padding or not. Defaults to `false`.
  final bool topPadding;

  /// Constructs a [LoadingIndicator] widget.
  const LoadingIndicator({super.key, this.topPadding = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding ? AppSizes.p12 : 0),
        child: const SizedBox(
          height: AppSizes.p32,
          width: AppSizes.p32,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
