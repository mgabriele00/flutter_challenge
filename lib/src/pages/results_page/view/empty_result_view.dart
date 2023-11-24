import 'package:flutter/material.dart';

class EmptyResultView extends StatelessWidget {
  const EmptyResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ops...')),
      body: const Center(child: Text('There are not dogs')),
    );
  }
}
