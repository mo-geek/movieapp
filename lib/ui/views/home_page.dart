import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/app/data_model/popular_ppl.dart';
import 'package:movieapp/app/data_model/popular_ppl_local.dart';
import 'package:movieapp/core/enums.dart';
import 'package:movieapp/core/viewmodel/home_page_vm.dart';
import 'package:movieapp/ui/shared/common_view/wait_view.dart';
import 'package:movieapp/ui/views/popular_person_page.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomePageViewModel(),
        onModelReady: (HomePageViewModel vm) {
          vm.initState();
        },
        onDispose: (HomePageViewModel vm) {
          vm.dispose();
        },
        builder: (BuildContext context, HomePageViewModel model,
                Widget? child) =>
            model.viewState == ViewState.busy
                ? const WaitForMoments()
                : model.viewState == ViewState.error &&
                        model.popularPpl == null &&
                        model.popularPersonDBList == null
                    ? Scaffold(
                        body: Container(
                          color: Colors.blue,
                          child:
                              const Center(child: Text('No Data Is Loaded !')),
                        ),
                      )
                    : Scaffold(
                        body: SafeArea(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          color: Colors.blue,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15.0,
                              ),
                              const Text('Main App Page !',
                                  style: TextStyle(fontSize: 35)),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Loaded Pages: ${model.popularPpl?.page ?? ''}'),
                                  Text(
                                      'Total Pages: ${model.popularPpl?.totalPages ?? ''}')
                                ],
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              model.resultsList == null &&
                                      model.popularPersonDBList!.isNotEmpty
                                  ? Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          controller: model.scrollController,
                                          itemCount:
                                              model.popularPersonDBList!.length,
                                          itemBuilder: (context, index) {
                                            PopularPersonDB? item = model
                                                .popularPersonDBList?[index];
                                            return model
                                                        .popularPersonDBList?[
                                                            index]
                                                        ?.gender ==
                                                    1
                                                ? Container()
                                                : InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  PopularPersonPage(
                                                                      item?.id)));
                                                    },
                                                    child: Card(
                                                      elevation: 31.0,
                                                      color: Colors.orange,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  'Name: ${item?.name}'),
                                                              const SizedBox(
                                                                height: 12.0,
                                                              ),
                                                              Text(
                                                                  'Career: ${item?.career}')
                                                            ]),
                                                      ),
                                                    ),
                                                  );
                                          }),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        controller: model.scrollController,
                                        itemCount:
                                            model.resultsList!.length + 1,
                                        itemBuilder: (context, index) {
                                          if (index <
                                              model.resultsList!.length) {
                                            Results? item =
                                                model.resultsList?[index];
                                            return model.resultsList?[index]
                                                        .gender ==
                                                    1
                                                ? Container()
                                                : InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  PopularPersonPage(
                                                                      item?.id)));
                                                    },
                                                    child: Card(
                                                      elevation: 31.0,
                                                      color: Colors.orange,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  'Name: ${item?.name}'),
                                                              const SizedBox(
                                                                height: 12.0,
                                                              ),
                                                              Text(
                                                                  'Career: ${item?.knownForDepartment}')
                                                            ]),
                                                      ),
                                                    ),
                                                  );
                                          } else {
                                            return model.noMoreData
                                                ? const Text('Last Page !!!')
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                    color: Colors.orange,
                                                  ));
                                          }
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        )),
                      ));
  }
}
