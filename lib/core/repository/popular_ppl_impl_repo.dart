import 'package:either_dart/either.dart';
import 'package:movieapp/app/locator.dart';
import 'package:movieapp/core/constant/const.dart';
import 'package:movieapp/core/repository/dio_repo.dart';
import 'package:movieapp/core/repository/popular_ppl_repo.dart';

class PopularPeopleImplRepository implements PopularPeopleRepository {
  final DioRepository _dioRepository = locator<DioRepository>();

  @override
  Future<Either<dynamic, APIError>> getPopularPpl({int? page}) {
    const String url = Constant.appUrl + Constant.popularPplEndP;
    Map<String, String> query = {
      "api_key": Constant.apiToken,
      "page": page.toString()
    };
    return _dioRepository.get(url: url, requestBody: query);
  }

  @override
  Future<Either<dynamic, APIError>> getPopularPersonById(String popularId) {
    final String url = Constant.appUrl + Constant.popularPersonEndP + popularId;
    Map<String, String> query = {
      "api_key": Constant.apiToken,
      "append_to_response": "images"
    };
    return _dioRepository.get(url: url, requestBody: query);
  }
}
