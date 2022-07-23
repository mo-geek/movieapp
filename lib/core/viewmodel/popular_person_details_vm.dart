import 'package:either_dart/either.dart';
import 'package:movieapp/app/data_model/popular_person.dart';
import 'package:movieapp/app/data_model/popular_ppl_local.dart';
import 'package:movieapp/app/locator.dart';
import 'dart:developer' as devtools;
import 'package:movieapp/core/enums.dart';
import 'package:movieapp/core/repository/dio_repo.dart';
import 'package:movieapp/core/repository/popular_ppl_local_repo.dart';
import 'package:movieapp/core/repository/popular_ppl_impl_repo.dart';
import 'package:movieapp/core/repository/popular_ppl_repo.dart';
import 'package:movieapp/ui/shared/toast/show_toast.dart';
import 'package:stacked/stacked.dart';

class PopularPersonDetailsViewModel extends BaseViewModel {
  late ViewState _viewState = ViewState.idle;
  ViewState get viewState => _viewState;
  PopularPerson? _popularPerson;
  PopularPerson? get popularPerson => _popularPerson;

  final PopularPeopleRepository _popularPeopleRepository =
      locator<PopularPeopleRepository>();
  final PopularPplDBRepository _popularPplDBRepository =
      locator<PopularPplDBRepository>();

  Future<void> savePopularPplImage(String url) async {
    print('savePopularPplImage');
    _popularPplDBRepository.savePopularPersonImage(url);
  }

  Future<void> getPopularPerson(String popularId) async {
    _viewState = ViewState.busy;
    final Either<dynamic, APIError> res =
        await _popularPeopleRepository.getPopularPersonById(popularId);
    res.fold((dynamic data) async {
      devtools.log(data.toString());
      final PopularPerson popularPerson =
          PopularPerson.fromJson(data as Map<String, dynamic>);
      _popularPerson = popularPerson;
      _viewState = ViewState.dataFetched;
    }, (APIError e) {
      devtools.log(e.toString());
      _viewState = ViewState.error;
      showToast(message: e.error);
    });
    notifyListeners();
  }

  void initState(String popularId) async {
    await getPopularPerson(popularId);
  }
}
