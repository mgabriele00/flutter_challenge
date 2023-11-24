import 'dart:convert';

import 'package:flutter_challenge/src/data/data_sources/dog_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../mock_data.dart';

class MockClient extends Mock implements http.Client{}

void main() {
  late final MockClient mockClient;
  late final DogDataSource dogDataSource;

  setUpAll(() {
    mockClient = MockClient();
    dogDataSource = DogDataSource(client: mockClient);
  });

  test('Should run correctly listAllDogs returning not null value', () async {
    when(() => mockClient.get(Uri.parse('https://dog.ceo/api/breeds/list/all')))
        .thenAnswer((_) async {
      final fakeBody = <String, dynamic>{
        'status': 'success',
        'message': MockData.fakeBreeds
      };
      final response = http.Response(jsonEncode(fakeBody), 200);
      return response;
    });
    final message = await dogDataSource.listAllBreeds();
    expect(message, MockData.fakeBreeds);
  });

  test('Should run incorrectly listAllDogs returning null value', () async {
    when(() => mockClient.get(Uri.parse('https://dog.ceo/api/breeds/list/all')))
        .thenAnswer((_) async {
      final fakeBody = <String, dynamic>{'message': MockData.fakeBreeds};
      final response = http.Response(jsonEncode(fakeBody), 400);
      return response;
    });
    final message = await dogDataSource.listAllBreeds();
    expect(message, null);
  });

  test('Should run correctly getImages returning not null value', () async {
    when(() => mockClient.get(Uri.parse('https://dog.ceo/api/breed/${MockData.exampleBreed}/images')))
        .thenAnswer((_) async {
      final fakeBody = <String, dynamic>{
        'status': 'success',
        'message': MockData.fakeImagesUrl
      };
      final response = http.Response(jsonEncode(fakeBody), 200);
      return response;
    });
    final message = await dogDataSource.getImages(MockData.exampleBreed);
    expect(message, MockData.fakeImagesUrl);
  });

  test('Should run incorrectly getImages returning null value', () async {
    when(() => mockClient.get(Uri.parse('https://dog.ceo/api/breed/${MockData.exampleBreed}/images')))
        .thenAnswer((_) async {
      final fakeBody = <String, dynamic>{'status': 'success', 'message': null};
      final response = http.Response(jsonEncode(fakeBody), 200);
      return response;
    });
    final message = await dogDataSource.getImages(MockData.exampleBreed);
    expect(message, null);
  });
}
