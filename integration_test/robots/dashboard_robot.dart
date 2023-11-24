import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/bloc/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

class DashboardRobot {
  final WidgetTester _tester;
  const DashboardRobot(this._tester);

  Future<void> _selectValueFromDropdown(
      String dropdownValueKey, String dropdownTextToTap) async {
    final dropdown = find.byKey(Key(dropdownValueKey));
    await _tester.tap(dropdown, warnIfMissed: false);
    await _tester.pumpAndSettle();
    final listDropdownItem = find.text(dropdownTextToTap);
    await _tester.tap(listDropdownItem);
    await _tester.pumpAndSettle();
  }

  Future<void> selectList() =>
      _selectValueFromDropdown('typeDropdown', DashboardViewType.list.message!);

  Future<void> selectRandom() =>
      _selectValueFromDropdown('typeDropdown', DashboardViewType.random.message!);

  Future<void> selectBreed() =>
      _selectValueFromDropdown('breedDropdown', 'australian');

  Future<void> selectSubBreed() =>
      _selectValueFromDropdown('subBreedDropdown', 'I do not have preferences');

  Future<void> search() async {
    final searchButton = find.byType(ElevatedButton);
    await _tester.tap(searchButton);
    await _tester.pumpAndSettle();
  }
}
