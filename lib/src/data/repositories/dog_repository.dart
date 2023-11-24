import 'package:flutter_challenge/src/core/exceptions/app_exception.dart';
import 'package:flutter_challenge/src/data/data_sources/dog_data_source.dart';
import 'package:flutter_challenge/src/data/models/dog/dog.dart';

/// A repository class responsible for interacting with dog-related data.
class DogRepository {
  final DogDataSource _dogDataSource;

  /// Constructs a DogRepository instance with a provided [dogDataSource].
  const DogRepository(this._dogDataSource);

  /// Retrieves a list of all dog breeds available as [Dog] objects.
  ///
  /// Throws a [DogLoadingFailureException] if the list of dog breeds cannot be retrieved.
  ///
  /// Returns a [List<Dog>] representing all dog breeds.
  Future<List<Dog>> getAllDogs() async {
    final dogsResponse = await _dogDataSource.listAllBreeds();
    if (dogsResponse == null) throw DogLoadingFailureException();
    final dogs = dogsResponse.toListDog();
    return dogs;
  }

  /// Retrieves a list of images for a specific [breed] as [String] URLs.
  ///
  /// Throws a [DogImagesFailureException] if the images for the specified breed cannot be retrieved.
  ///
  /// [breed] is a [String] representing the breed of the dog for which images are to be fetched.
  ///
  /// Returns a [List<String>] containing URLs representing images of the specified breed.
  Future<List<String>> getDogImages(String breed) async {
    final imagesUrl = await _dogDataSource.getImages(breed);
    if (imagesUrl == null) throw DogImagesFailureException();
    return imagesUrl;
  }
}
