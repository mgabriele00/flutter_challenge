import 'package:flutter_challenge/src/data/models/dog/dog.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mock_data.dart';

void main() {
  test('Should convert a message response into List<Dog>', () {

    const expectedResult = <Dog>[
      Dog(breed: 'breed1', subBreeds: ['subBreed1', 'subBreed2', 'subBreed3']),
      Dog(breed: 'breed2', subBreeds: []),
      Dog(breed: 'breed3', subBreeds: ['subBreed1'])
    ];

    expect(MockData.fakeBreeds.toListDog(), expectedResult);
  });
}
