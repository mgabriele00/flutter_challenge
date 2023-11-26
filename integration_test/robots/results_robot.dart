import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/pages/results_page/view/widgets/rounded_network_image.dart';
import 'package:flutter_test/flutter_test.dart';

class ResultsRobot {
  final WidgetTester tester;

  const ResultsRobot(this.tester);

  void ensureRandomImageView() {
    expect(find.text('Doggy!'), findsOneWidget);
  }

  void ensureImageListView() {
    expect(find.byType(ListView), findsOneWidget);
  }

  void ensureOneImageDisplayed(){
    int numberOfImages = tester.widgetList(find.byType(RoundedNetworkImage)).length;
    expect(numberOfImages, 1);
  }

  Future<void> scrollAllList() async {
    const maxIteration = 50;

    for(int iteration = 0; iteration < maxIteration; iteration++){
      final finder = find.byWidgetPredicate((widget) =>
      widget.key == const Key('loadingIndicator') ||
          widget.key == const Key('endingText'));
      await tester.scrollUntilVisible(finder, 200);
      await tester.pumpAndSettle();

      if (find.byKey(const Key('endingText')).evaluate().isNotEmpty) {
        break;
      }
    }

    expect(find.byKey(const Key('endingText')), findsOneWidget);
  }
}
