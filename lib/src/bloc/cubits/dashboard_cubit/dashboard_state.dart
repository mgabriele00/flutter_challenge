part of 'dashboard_cubit.dart';

/// Enum defining different view types for the Dashboard.
///
/// Represents various view types such as showing a random dog, displaying a list of dogs, or an empty view.
enum DashboardViewType {
  random('Just one random dog'),
  list('A lot of dogs!'),
  empty(null);

  const DashboardViewType(this.message);
  final String? message;
}

/// Represents the state for the Dashboard feature.
///
/// Uses freezed package for concise immutable class generation.
///
/// [isLoading]: Indicates whether the Dashboard is in a loading state.
/// [viewType]: Represents the current view type of the Dashboard (random, list, or empty).
/// [dogs]: List of Dog objects to display.
/// [picturesToShow]: List of URLs for images to show in the UI.
/// [selectedBreedPictures]: List of URLs for images of the selected breed.
/// [isLoadingPictures]: Indicates if images are currently being loaded.
/// [selectedBreed]: Selected breed for which images are being fetched.
/// [selectedSubBreed]: Selected sub-breed if applicable.
/// [error]: Represents any error that occurred during data fetching.
@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(true) bool isLoading,
    @Default(DashboardViewType.empty) DashboardViewType viewType,
    @Default([]) List<Dog> dogs,
    @Default([]) List<String> picturesToShow,
    @Default([]) List<String> selectedBreedPictures,
    @Default(false) bool isLoadingPictures,
    String? selectedBreed,
    String? selectedSubBreed,
    AppException? error,
  }) = _DashboardState;
}
