import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/app/data_model/popular_ppl.dart';
import 'package:movieapp/app/data_model/popular_ppl_local.dart';
import 'package:movieapp/app/locator.dart';
import 'dart:developer' as devtools;
import 'package:movieapp/core/enums.dart';
import 'package:movieapp/core/repository/dio_repo.dart';
import 'package:movieapp/core/repository/popular_ppl_local_repo.dart';
import 'package:movieapp/core/repository/popular_ppl_repo.dart';
import 'package:movieapp/ui/shared/toast/show_toast.dart';
import 'package:stacked/stacked.dart';

class HomePageViewModel extends BaseViewModel {
  bool _noMoreData = false;
  bool get noMoreData => _noMoreData;
  final scrollController = ScrollController();
  late ViewState _viewState = ViewState.idle;
  ViewState get viewState => _viewState;
  PopularPpl? _popularPpl;
  PopularPpl? get popularPpl => _popularPpl;
  List<Results>? _resultsList;
  set resultsListL(List<Results> value) {
    _resultsList = value;
  }

  List<Results>? get resultsList => _resultsList;
  List<PopularPersonDB?>? _popularPersonDBList;
  List<PopularPersonDB?>? get popularPersonDBList => _popularPersonDBList;
  final PopularPplDBRepository _popularPplDBRepository =
      locator<PopularPplDBRepository>();
  final PopularPeopleRepository _popularPeopleRepository =
      locator<PopularPeopleRepository>();

  Future<void> getPopularPpl({int page = 1}) async {
    _viewState = ViewState.busy;
    // notifyListeners();
    final Either<dynamic, APIError> res =
        await _popularPeopleRepository.getPopularPpl(page: page);
    res.fold((dynamic data) async {
      devtools.log(data.toString());
      final PopularPpl popularPpl = PopularPpl.fromJson(data);
      _popularPpl = popularPpl;
      if (page == 1) {
        _resultsList = popularPpl.results;
      } else {
        _resultsList?.addAll(popularPpl.results ?? []);
      }
      savePopularPplListInDB(_resultsList);
      _viewState = ViewState.dataFetched;
    }, (APIError e) async {
      devtools.log(e.toString());
      await _getPopularPersonDBList();
      _viewState = ViewState.error;
      showToast(message: e.error);
    });
    notifyListeners();
  }

  Future<void> _getPopularPersonDBList() async {
    _popularPersonDBList = await _popularPplDBRepository.readAllPopularPpl();
    notifyListeners();
  }

  void initState() async {
    await getPopularPpl();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        // check for last page !!!
        if (_popularPpl!.page! < _popularPpl!.totalPages!) {
          getPopularPpl(page: _popularPpl!.page! + 1);
        } else {
          _noMoreData = true;
          notifyListeners();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void savePopularPplListInDB(List<Results>? resultsList) {
    resultsList?.forEach((e) {
      _popularPplDBRepository.addPopularPerson(PopularPersonDB(
          id: e.id,
          career: e.knownForDepartment,
          name: e.name,
          gender: e.gender));
    });
  }
}
