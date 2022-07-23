import 'package:get_it/get_it.dart';
import 'package:movieapp/core/repository/dio_repo.dart';
import 'package:movieapp/core/repository/popular_ppl_impl_repo.dart';
import 'package:movieapp/core/repository/popular_ppl_local_repo.dart';
import 'package:movieapp/core/repository/popular_ppl_repo.dart';
import 'package:movieapp/core/utility/db.dart';

final GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => DioRepository());
  locator.registerLazySingleton<PopularPeopleRepository>(
      () => PopularPeopleImplRepository());
  locator.registerLazySingleton(() => DataBase());
  locator.registerLazySingleton(() => PopularPplDBRepository());
}
