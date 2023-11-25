import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_challenge/src/bloc/cubits/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter_challenge/src/data/models/dog/dog.dart';
import 'package:flutter_challenge/src/data/repositories/dog_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock_data.dart';

class MockDogRepository extends Mock implements DogRepository {}

void main() {
  late final MockDogRepository dogRepository;
  const selectedBreed = 'breed1';
  const selectedSubBreed = 'subBreed1';

  setUpAll(() {
    dogRepository = MockDogRepository();
    when(() => dogRepository.getAllDogs())
        .thenAnswer((_) async => MockData.fakeBreeds.toListDog());
    when(() => dogRepository.getDogImages(selectedBreed))
        .thenAnswer((_) async => MockData.fakeImagesUrl);
  });

  blocTest<DashboardCubit, DashboardState>(
    'should get all dogs',
    build: () => DashboardCubit(dogRepository),
    act: (cubit) async {
      await cubit.getDogs();
    },
    expect: () => <DashboardState>[
      DashboardState(
          isLoadingDogs: false,
          viewType: DashboardViewType.empty,
          dogs: MockData.fakeBreeds.toListDog())
    ],
  );

  blocTest<DashboardCubit, DashboardState>(
    'emit correct picturesToShow when no sub breed selected and view type is list',
    build: () => DashboardCubit(dogRepository),
    act: (cubit) async {
      await cubit.onChangeBreed(selectedBreed);
    },
    seed: () => DashboardState(
        isLoadingDogs: false,
        dogs: MockData.fakeBreeds.toListDog(),
        viewType: DashboardViewType.list),
    expect: () => <DashboardState>[
      DashboardState(
        isLoadingDogs: false,
        viewType: DashboardViewType.list,
        dogs: MockData.fakeBreeds.toListDog(),
        picturesToShow: [],
        selectedBreedPictures: [],
        isLoadingPictures: true,
        selectedBreed: null,
        selectedSubBreed: null
      ),
      DashboardState(
          isLoadingDogs: false,
          viewType: DashboardViewType.list,
          dogs: MockData.fakeBreeds.toListDog(),
          selectedBreedPictures: MockData.fakeImagesUrl,
          selectedBreed: selectedBreed,
          isLoadingPictures: false,
          picturesToShow: MockData.fakeImagesUrl,
          error: null)
    ],
  );

  blocTest<DashboardCubit, DashboardState>(
    'emit correct picturesToShow when no sub breed selected and view type is random',
    build: () => DashboardCubit(dogRepository),
    act: (cubit) async {
      await cubit.onChangeBreed(selectedBreed);
    },
    seed: () => DashboardState(
        isLoadingDogs: false,
        dogs: MockData.fakeBreeds.toListDog(),
        viewType: DashboardViewType.random),
    verify: (cubit) =>
        cubit.state.picturesToShow.length == 1 &&
        MockData.fakeImagesUrl.contains(cubit.state.picturesToShow.first),
  );

  blocTest<DashboardCubit, DashboardState>(
    'emit correct picturesToShow when sub breed is selected and view type is list',
    build: () => DashboardCubit(dogRepository),
    act: (cubit) async {
      cubit.onChangeSubBreed(selectedSubBreed);
    },
    seed: () => DashboardState(
        isLoadingDogs: false,
        dogs: MockData.fakeBreeds.toListDog(),
        viewType: DashboardViewType.list,
        picturesToShow: MockData.fakeImagesUrl,
        selectedBreedPictures: MockData.fakeImagesUrl,
        selectedBreed: selectedBreed),
    expect: () => <DashboardState>[
      DashboardState(
          isLoadingDogs: false,
          viewType: DashboardViewType.list,
          dogs: MockData.fakeBreeds.toListDog(),
          selectedBreedPictures: MockData.fakeImagesUrl,
          selectedBreed: selectedBreed,
          selectedSubBreed: selectedSubBreed,
          picturesToShow: [
            'breed1-subBreed1-1',
            'breed1-subBreed1-2',
          ],
          isLoadingPictures: false,
          error: null)
    ],
  );

  blocTest<DashboardCubit, DashboardState>(
      'emit correct picturesToShow when sub breed is selected and view type is random',
      build: () => DashboardCubit(dogRepository),
      act: (cubit) async {
        cubit.onChangeSubBreed(selectedSubBreed);
      },
      seed: () => DashboardState(
          isLoadingDogs: false,
          dogs: MockData.fakeBreeds.toListDog(),
          viewType: DashboardViewType.random,
          picturesToShow: MockData.fakeImagesUrl,
          selectedBreedPictures: MockData.fakeImagesUrl,
          selectedBreed: selectedBreed),
      verify: (cubit) =>
          cubit.state.picturesToShow == ['breed1-subBreed1-1'] ||
          cubit.state.picturesToShow == ['breed1-subBreed1-2']);
}