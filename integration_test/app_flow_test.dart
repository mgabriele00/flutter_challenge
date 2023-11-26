import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robots/robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration test on typical app flow', () {
    testWidgets('dashboard to list of images', (tester) async {

      final robot = Robot(tester);
      await robot.setup();

      await robot.dashboard.selectList();
      await robot.dashboard.selectBreed();
      await robot.dashboard.selectSubBreed();

      await robot.dashboard.search();

      robot.results.ensureImageListView();

      await robot.results.scrollAllList();
    });

    testWidgets('dashboard to random image', (tester) async {
      final robot = Robot(tester);
      await robot.setup();

      await robot.dashboard.selectRandom();
      await robot.dashboard.selectBreed();
      await robot.dashboard.selectSubBreed();

      await robot.dashboard.search();

      robot.results.ensureRandomImageView();
      robot.results.ensureOneImageDisplayed();
    });
  });
}
