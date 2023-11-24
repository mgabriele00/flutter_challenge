import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/core/constants/app_sizes.dart';
import 'package:flutter_challenge/src/pages/results_page/view/widgets/rounded_network_image.dart';

class SingleResultView extends StatelessWidget {
  final String imageUrl;

  const SingleResultView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Doggy!'),
        ),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.p12),
              child: RoundedNetworkImage(
                imageUrl: imageUrl,
              ),
            ),
          ],
        )));
  }
}
