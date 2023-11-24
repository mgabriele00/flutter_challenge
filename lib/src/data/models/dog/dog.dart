import 'package:equatable/equatable.dart';

/// A class representing a Dog entity with its breed and sub-breeds if any.
class Dog extends Equatable {
  /// The breed of the dog.
  final String breed;

  /// List of sub-breeds under the main breed.
  final List<String> subBreeds;

  /// Constructs a Dog instance with a [breed] and optional [subBreeds].
  const Dog({required this.breed, this.subBreeds = const []});

  /// Represents an empty Dog instance with an empty breed.
  static Dog empty = const Dog(breed: '');

  @override
  List<Object?> get props => [breed, subBreeds];
}

/// An extension on [Map<String, dynamic>] to convert it into a list of [Dog] objects.
extension GetListOfDogs on Map<String, dynamic> {
  /// Converts the Map into a List of [Dog] objects.
  ///
  /// Returns a [List<Dog>] where each entry in the map represents a Dog with its breed and sub-breeds.
  List<Dog> toListDog() => entries
      .map((e) => Dog(breed: e.key, subBreeds: List<String>.from(e.value)))
      .toList();
}
