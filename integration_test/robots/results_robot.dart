import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ResultsRobot{
  const ResultsRobot();

  void ensureRandomImageView(){
    expect(find.text('Doggy!'), findsOneWidget);
  }

  void ensureImageListView(){
    expect(find.byType(ListView), findsOneWidget);
  }
}