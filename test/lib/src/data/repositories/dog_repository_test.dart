import 'package:flutter_challenge/src/core/exceptions/app_exception.dart';
import 'package:flutter_challenge/src/data/data_sources/dog_data_source.dart';
import 'package:flutter_challenge/src/data/models/dog/dog.dart';
import 'package:flutter_challenge/src/data/repositories/dog_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock_data.dart';

class MockDogDataSource extends Mock implements DogDataSource{}

void main() {
  late final MockDogDataSource mockDogDataSource;
  late final DogRepository dogRepository;
  setUpAll(() {
    mockDogDataSource = MockDogDataSource();
    dogRepository = DogRepository(mockDogDataSource);
  });


  test('Should get all breeds', () async {
    when(() => mockDogDataSource.listAllBreeds()).thenAnswer((_) async {
      return MockData.fakeBreeds;
    });
    final result = await dogRepository.getAllDogs();
    final expectedResult = MockData.fakeBreeds.toListDog();
    expect(result, equals(expectedResult));
  });

  test('Should throw exception while get all breeds', () async {
    when(() => mockDogDataSource.listAllBreeds()).thenAnswer((_) async {
      return null;
    });
    expect(() => dogRepository.getAllDogs(),
        throwsA(isA<DogLoadingFailureException>()));
  });

  test('Should get all images of a breed', () async {
    when(() => mockDogDataSource.getImages(MockData.exampleBreed)).thenAnswer((_) async {
      return MockData.fakeImagesUrl;
    });
    final result = await dogRepository.getDogImages(MockData.exampleBreed);
    const expectedResult = MockData.fakeImagesUrl;
    expect(result, equals(expectedResult));
  });

  test('Should throw exception while get all images url of a breed', () async {
    when(() => mockDogDataSource.getImages(MockData.exampleBreed)).thenAnswer((_) async {
      return null;
    });
    expect(() => dogRepository.getDogImages(MockData.exampleBreed),
        throwsA(isA<DogImagesFailureException>()));
  });
}
