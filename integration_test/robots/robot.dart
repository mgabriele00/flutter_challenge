import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/my_app.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dashboard_robot.dart';
import 'results_robot.dart';

class Robot {
  final WidgetTester _tester;
  final DashboardRobot dashboard;
  final ResultsRobot results;

  Robot(this._tester)
      : dashboard = DashboardRobot(_tester),
        results = const ResultsRobot();

  Future<void> setup() async {
    await _tester.pumpWidget(const MyApp());
    await _tester.pumpAndSettle();
    expect(find.byKey(const Key('screenHeading')), findsOneWidget);
  }
}
