import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_challenge/src/core/exceptions/app_exception.dart';
import 'package:flutter_challenge/src/data/models/dog/dog.dart';
import 'package:flutter_challenge/src/data/repositories/dog_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.dart';

part 'dashboard_cubit.freezed.dart';

/// A Cubit responsible for managing the state related to the Dashboard feature.
class DashboardCubit extends Cubit<DashboardState> {
  /// Constructs a DashboardCubit with a [DogRepository] instance and initializes the state.
  DashboardCubit(this._dogRepository) : super(const DashboardState());

  /// Fetches a list of all dog breeds and updates the state.
  ///
  /// Returns a [bool] with a boolean value indicating the success of fetching dogs.
  Future<bool> getDogs() async {
    try {
      if (!state.isLoading) {
        emit(state.copyWith(isLoading: true, error: null));
      }
      final dogs = await _dogRepository.getAllDogs();
      emit(state.copyWith(dogs: dogs, isLoading: false, error: null));
      return true;
    } on DogLoadingFailureException catch (e) {
      emit(state.copyWith(error: e));
      return false;
    }
  }

  /// Changes the view type of the Dashboard.
  ///
  /// [value] represents the selected view type as a String.
  /// Updates the state with the selected view type.
  void onChangeViewType(String? value) {
    DashboardViewType viewType = DashboardViewType.values.firstWhere(
        (element) => element.message == value,
        orElse: () => DashboardViewType.empty);
    emit(state.copyWith(
      viewType: viewType,
    ));
  }

  /// Changes the selected breed for which images are fetched.
  ///
  /// [value] represents the selected breed as a String.
  /// Fetches dog images for the selected breed and updates the state accordingly.
  Future<void> onChangeBreed(String? value) async {
    if (value != null) {
      try {
        final pictures = await _dogRepository.getDogImages(value);
        emit(state.copyWith(
            selectedBreed: value,
            selectedSubBreed: null,
            selectedBreedPictures: pictures,
            picturesToShow: pictures,
            error: null));
      } on DogImagesFailureException catch (e) {
        emit(state.copyWith(
          error: e,
          selectedBreed: value,
          selectedSubBreed: null,
        ));
      }
    }
  }

  /// Changes the selected sub-breed for which images are fetched.
  ///
  /// [value] represents the selected sub-breed as a String.
  /// Updates the state with the selected sub-breed and filters the images accordingly.
  void onChangeSubBreed(String? value) {
    if (value != null) {
      emit(state.copyWith(
          selectedSubBreed: value,
          picturesToShow: value == 'I do not have preferences'
              ? state.selectedBreedPictures
              : state.selectedBreedPictures
                  .where((element) => element.contains('-$value'))
                  .toList()));
    }
  }
  /// Retrieves a list of sub-breeds for the currently selected breed.
  ///
  /// Returns a [List<String>] containing sub-breeds of the selected breed.
  /// If no sub-breeds are available, an empty list with a default option ('I do not have preferences') is returned.
  List<String> getSubBreeds() {
    final subBreeds = state.dogs
        .firstWhere((e) => e.breed == state.selectedBreed,
            orElse: () => Dog.empty)
        .subBreeds
        .toList();
    subBreeds.insert(0, 'I do not have preferences');
    return subBreeds;
  }

  /// Checks if the sub-breed selection should be visible in the UI.
  ///
  /// Returns a [bool] indicating the visibility of the sub-breed selection.
  bool isSubBreedVisible() {
    return !state.isLoadingPictures && _existSubBreed();
  }

  /// Checks if the selected breed has sub-breeds.
  ///
  /// Returns a [bool] indicating the existence of sub-breeds for the selected breed.
  bool _existSubBreed() {
    if (state.selectedBreed != null &&
        state.dogs
            .firstWhere((element) => element.breed == state.selectedBreed)
            .subBreeds
            .isNotEmpty) {
      return true;
    }
    return false;
  }

  /// Retrieves a list of images based on the selected view type.
  ///
  /// If the view type is 'list', returns [state.picturesToShow].
  /// If the view type is 'random', returns a single random image from [state.picturesToShow].
  /// Returns a [List<String>] containing images based on the selected view type.
  List<String> getImagesToShow() {
    final isList = state.viewType == DashboardViewType.list;
    final images = isList ? state.picturesToShow : _getRandomImage();
    return images;
  }

  /// Retrieves a random image from the list of images.
  ///
  /// If [state.picturesToShow] is empty, returns an empty list.
  /// Returns a [List<String>] containing a single randomly selected image from [state.picturesToShow].
  List<String> _getRandomImage() {
    if(state.picturesToShow.isEmpty){
      return [];
    }
    final random = Random();
    final randomIndex = random.nextInt(state.picturesToShow.length);
    return [state.picturesToShow[randomIndex]];
  }

  /// Repository responsible for fetching dog-related data.
  final DogRepository _dogRepository;
}
