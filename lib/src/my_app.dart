import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/src/bloc/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_challenge/src/core/themes/app_themes.dart';
import 'package:flutter_challenge/src/data/data_sources/dog_data_source.dart';
import 'package:flutter_challenge/src/data/repositories/dog_repository.dart';

import 'pages/dashboard_page/dashboard_page.dart';

/// The main entry point for the application.
///
/// This StatelessWidget is responsible for configuring and setting up the app's structure.
/// It initializes necessary data sources, repositories, themes, and provides them to the app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize data source for dog-related data
    final dogDataSource = DogDataSource();

    // Obtain the initial brightness based on the platform's brightness
    final initialBrightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    return RepositoryProvider(
      // Provide the DogRepository to the app using RepositoryProvider
      create: (context) => DogRepository(dogDataSource),
      child: BlocProvider(
        // Provide the ThemeCubit to handle theme changes using BlocProvider
        create: (context) => ThemeCubit(initialBrightness: initialBrightness),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Doggyboard',
              // Set the app's theme based on the state managed by ThemeCubit
              theme: AppThemes.theme(state.brightness),
              home: const DashboardPage(), // Set the initial page of the app
            );
          },
        ),
      ),
    );
  }
}
