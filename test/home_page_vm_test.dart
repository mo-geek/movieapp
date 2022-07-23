import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movieapp/app/locator.dart';
import 'package:movieapp/core/enums.dart';
import 'package:movieapp/core/repository/dio_repo.dart';
import 'package:movieapp/core/repository/popular_ppl_local_repo.dart';
import 'package:movieapp/core/repository/popular_ppl_repo.dart';
import 'package:movieapp/core/utility/db.dart';
import 'package:movieapp/core/viewmodel/home_page_vm.dart';

class MockPopularPeopleRepo extends Mock implements PopularPeopleRepository {
  // mock the actual PopularPeople service
  // we don't have any implementation in this class
  // instead we setup the implementation for every test
}

void setupLocatorForTests() {
  locator.registerLazySingleton<PopularPeopleRepository>(
      () => MockPopularPeopleRepo());
  locator.registerLazySingleton(() => DataBase());
  locator.registerLazySingleton(() => PopularPplDBRepository());
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupLocatorForTests();

  // it runs before every test
  setUp(body) {}

  group(
      'validates initial values,'
      'mocked api service\'s "getPopularPpl" method is called when getPopularPpl on view model is called,'
      '', () {
    // test 1
    test('initial values as expected', () {
      HomePageViewModel homePageViewModel = HomePageViewModel();
      expect(homePageViewModel.viewState, ViewState.idle);
      expect(homePageViewModel.resultsList, null);
    });
    //
    // test 2
    test(
        "when getPopularPpl on view model is called with the first page check that getPopulalPpl"
        " is called once on the repository with the first page", () async {
      PopularPeopleRepository mockedPopularPplRepo =
          locator<PopularPeopleRepository>();

      HomePageViewModel homePageViewModel = HomePageViewModel();
      // arrange
      // define a particular implementation as the method "getPopularPpl"
      // in the mockedPopularPpl service get invoked.
      when(() => mockedPopularPplRepo.getPopularPpl(page: 1))
          .thenAnswer((data) {
        return Future.value(const Left(<String, dynamic>{}));
      });
      // act
      await homePageViewModel.getPopularPpl(page: 1);
      // assert that the method invoked in mocked api-service is called once
      // as we call the homePageViewModel's getPopularPpl method
      verify(() => mockedPopularPplRepo.getPopularPpl(page: 1)).called(1);
    });

    // test 3
    test(
        "the view's state is set to busy as the method getPopularPpl on home page view model is called,"
        "the view's state is set to data fetched as the method getPopularPpl is called successfully",
        () async {
      PopularPeopleRepository mockedPopularPplRepo =
          locator<PopularPeopleRepository>();
      HomePageViewModel homePageViewModel = HomePageViewModel();
      when(() => mockedPopularPplRepo.getPopularPpl(page: 1))
          .thenAnswer((data) {
        return Future.value(const Left(<String, dynamic>{}));
      });
      homePageViewModel.getPopularPpl().then((value) {
        expect(homePageViewModel.viewState, ViewState.dataFetched);
      });
      expect(homePageViewModel.viewState, ViewState.busy);
    });
  });

  // test 4
  // test(
  //     "the view's state is set to error as the method getPopularPpl is called on error",
  //     () async {
  //   PopularPeopleRepository mockedPopularPplRepo =
  //       locator<PopularPeopleRepository>();
  //   HomePageViewModel homePageViewModel = HomePageViewModel();
  //   when(() => mockedPopularPplRepo.getPopularPpl(page: 1)).thenAnswer((data) {
  //     return Future.value(Right(APIError(error: '', status: 1, message: '')));
  //   });
  //   homePageViewModel.getPopularPpl().then((value) {
  //     expect(homePageViewModel.viewState, ViewState.error);
  //   });
  // });
}

//
// final Either<dynamic, APIError> res =
//     await mockedPopularPplRepo.getPopularPpl();
//
// when(res.fold(
//     (data) => () => PopularPpl.fromJson(data as Map<String, dynamic>),
//     (right) => () => HttpException("DSDSD")));
//
// res.fold((left) => null, (right) => null);
