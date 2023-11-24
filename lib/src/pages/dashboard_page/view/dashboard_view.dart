import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/src/bloc/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter_challenge/src/bloc/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_challenge/src/core/constants/app_sizes.dart';
import 'package:flutter_challenge/src/core/exceptions/app_exception.dart';
import 'package:flutter_challenge/src/pages/dashboard_page/view/widgets/fade_in_from_left_widget.dart';
import 'package:flutter_challenge/src/pages/results_page/results_page.dart';
import 'package:flutter_challenge/src/pages/dashboard_page/view/widgets/text_field_with_dropdown.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final cubit = context.read<DashboardCubit>();
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        onPressed: context.read<ThemeCubit>().switchBrightness,
                        icon: const Icon(Icons.brightness_4_outlined)),
                  ),
                  const Spacer(),
                  Text(
                    'Doggyboard 🐶',
                    style: Theme.of(context).textTheme.titleLarge,
                    key: const Key('screenHeading'),
                  ),
                  const Text('Welcome to your doggyboard, search your puppy!'),
                  gapH20,
                  TextFieldWithDropdown(
                      key: const Key('typeDropdown'),
                      hintText: 'How many dogs?',
                      currentValue: state.viewType.message,
                      items: DashboardViewType.values
                          .where((type) => type.message != null)
                          .map((type) => "${type.message}")
                          .toList(),
                      onChanged: cubit.onChangeViewType),
                  gapH12,
                  TextFieldWithDropdown(
                      key: const Key('breedDropdown'),
                      visible: state.viewType != DashboardViewType.empty,
                      hintText: 'Which breed?',
                      currentValue: state.selectedBreed,
                      items: state.dogs.map((e) => e.breed).toList(),
                      onChanged: cubit.onChangeBreed),
                  gapH12,
                  TextFieldWithDropdown(
                      key: const Key('subBreedDropdown'),
                      hintText: 'Which sub-breed?',
                      visible: cubit.isSubBreedVisible(),
                      currentValue: state.selectedSubBreed,
                      items: cubit.getSubBreeds(),
                      onChanged: cubit.onChangeSubBreed),
                  gapH16,
                  Visibility(
                    visible: state.viewType != DashboardViewType.empty &&
                        state.selectedBreed != null,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SlideInFromLeft(
                        child: ElevatedButton(
                            onPressed: () {
                              if (state.error is DogImagesFailureException) {
                                final scaffoldMessengerState =
                                    ScaffoldMessenger.of(context);
                                scaffoldMessengerState.removeCurrentSnackBar();
                                scaffoldMessengerState.showSnackBar(SnackBar(
                                    content: Text(state.error!.message)));
                              } else {
                                final images = cubit.getImagesToShow();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ResultsPage(
                                        images: images,
                                        isList: state.viewType ==
                                            DashboardViewType.list)));
                              }
                            },
                            child: const Text('Search 🐾')),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
