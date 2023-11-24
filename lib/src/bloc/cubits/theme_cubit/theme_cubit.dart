import 'dart:ui';

import 'package:bloc/bloc.dart';

part 'theme_state.dart';

/// A Cubit responsible for managing the theme brightness of the application.
///
/// Manages the state related to the theme's brightness (light or dark mode).
class ThemeCubit extends Cubit<ThemeState> {
  /// Constructs a [ThemeCubit] instance with the specified [initialBrightness].
  ///
  /// Initializes the state with the provided initial [Brightness].
  ThemeCubit({required Brightness initialBrightness})
      : super(ThemeState(brightness: initialBrightness));

  /// Toggles the brightness mode between light and dark and emits the updated state.
  void switchBrightness() =>
      emit(ThemeState(brightness: state.brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light));
}
