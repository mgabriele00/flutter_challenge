import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/src/bloc/cubits/dashboard_cubit/dashboard_cubit.dart';

import '../../../core/constants/app_sizes.dart';

class DashboardLoadingErrorView extends StatelessWidget {
  const DashboardLoadingErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          Text(
            'There was an error while loading dogs',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          gapH8,
          ElevatedButton(
              onPressed: () async {
                final success = await cubit.getDogs();
                if (!success && context.mounted) {
                  final scaffoldMessengerState = ScaffoldMessenger.of(context);
                  scaffoldMessengerState.removeCurrentSnackBar();
                  scaffoldMessengerState.showSnackBar(const SnackBar(
                      content: Text('There was still an error')));
                }
              },
              child: const Text('Try again'))
        ],
      ),
    );
  }
}
