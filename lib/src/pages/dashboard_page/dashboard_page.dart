import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/bloc/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/src/core/exceptions/app_exception.dart';
import 'package:flutter_challenge/src/data/repositories/dog_repository.dart';
import 'package:flutter_challenge/src/pages/dashboard_page/view/dasboard_loading_error_view.dart';
import 'package:flutter_challenge/src/pages/dashboard_page/view/dashboard_view.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardCubit(context.read<DogRepository>())..getDogs(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if(state.error is DogLoadingFailureException){
            return const DashboardLoadingErrorView();
          }
          return const DashboardView();
        },
      )
    );
  }
}
