/// A sealed class representing an application-specific exception.
///
/// Extends [Exception] class and defines [code] and [message] properties.
///
/// This class is not intended to be instantiated directly, but serves as a base class
/// for more specific exceptions within the application.
///
/// Implementations of this class should override the [toString] method to provide
/// a meaningful representation of the exception message.
///
/// Example usage: Extend this class to create specific exceptions related to different error scenarios.
///
/// ```dart
/// class CustomException extends AppException {
///   CustomException() : super('custom-error-code', 'Custom error message');
/// }
/// ```
sealed class AppException implements Exception {
  final String code;
  final String message;

  /// Constructs an [AppException] instance with a [code] and a [message].
  AppException(this.code, this.message);

  @override
  String toString() => message;
}

/// Exception representing a failure while loading dogs.
///
/// Extends [AppException] class and provides a specific error code and message.
///
/// Example usage: Thrown when there is an error while fetching dogs.
class DogLoadingFailureException extends AppException {
  /// Constructs a [DogLoadingFailureException] instance with a specific error code and message.
  DogLoadingFailureException()
      : super('dog-loading-failure-exception', 'There was an error while fetching dogs');
}

/// Exception representing a failure while fetching dog images.
///
/// Extends [AppException] class and provides a specific error code and message.
///
/// Example usage: Thrown when there is an error while fetching dog images for a specific breed.
class DogImagesFailureException extends AppException {
  /// Constructs a [DogImagesFailureException] instance with a specific error code and message.
  DogImagesFailureException()
      : super('dog-images-failure-exception', 'There was an error while fetching dogs images, try with another breed');
}
