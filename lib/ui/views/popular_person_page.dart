import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:movieapp/app/data_model/popular_person.dart';
import 'package:movieapp/core/enums.dart';
import 'package:movieapp/core/viewmodel/popular_person_details_vm.dart';
import 'package:movieapp/ui/shared/common_view/wait_view.dart';
import 'package:movieapp/ui/views/original_image_page.dart';
import 'package:stacked/stacked.dart';
import '../../core/constant/const.dart';

class PopularPersonPage extends StatelessWidget {
  final int? popularPersonId;
  const PopularPersonPage(this.popularPersonId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onModelReady: (PopularPersonDetailsViewModel vm) {
          vm.initState(popularPersonId.toString());
        },
        viewModelBuilder: () => PopularPersonDetailsViewModel(),
        builder: (BuildContext context, PopularPersonDetailsViewModel model,
                Widget? child) =>
            model.viewState == ViewState.busy
                ? const WaitForMoments()
                : Scaffold(
                    appBar: AppBar(
                        title: const Text('Popular Person Page !',
                            style: TextStyle(fontSize: 35))),
                    body: LayoutBuilder(
                      builder: (context, constraint) => SingleChildScrollView(
                        child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: constraint.maxHeight),
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              color: Colors.blue,
                              child: Column(children: [
                                const SizedBox(
                                  height: 42.0,
                                ),
                                Text('Name: ${model.popularPerson?.name}',
                                    style: Constant.primaryTextStyle),
                                Text(
                                    'Known As: ${model.popularPerson?.alsoKnownAs?[0] ?? '----'}',
                                    style: Constant.primaryTextStyle),
                                const SizedBox(height: 22.0),
                                Text(
                                    'Biography: \n ${model.popularPerson?.biography ?? 'Has no biography yet!'}',
                                    style: Constant.primaryTextStyle.copyWith(
                                        overflow: TextOverflow.visible)),
                                const SizedBox(height: 12.0),
                                GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: model.popularPerson?.images
                                        ?.profiles?.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 12.0,
                                            crossAxisSpacing: 7.0,
                                            crossAxisCount: 2),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Profiles? item = model.popularPerson
                                          ?.images?.profiles?[index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      PopularPersonOriginalImg(
                                                        imgFilePath:
                                                            item?.filePath,
                                                        saveImage: () async {
                                                          await model
                                                              .savePopularPplImage(
                                                                  '${Constant.baseUrlImgW185}${item?.filePath}');
                                                        },
                                                      )));
                                        },
                                        child: Image.network(
                                            '${Constant.baseUrlImgW185}${item?.filePath}'),
                                      );
                                    }),
                                const SizedBox(height: 21.0),
                              ]),
                            )),
                      ),
                    )));
  }
}
