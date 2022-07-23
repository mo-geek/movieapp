import 'package:either_dart/either.dart';
import 'package:movieapp/core/repository/dio_repo.dart';

abstract class PopularPeopleRepository {
  Future<Either<dynamic, APIError>> getPopularPpl({int? page});

  Future<Either<dynamic, APIError>> getPopularPersonById(String popularId);
}
