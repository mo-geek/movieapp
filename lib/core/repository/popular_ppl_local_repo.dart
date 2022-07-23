import 'dart:io';
import 'package:dio/dio.dart';
import 'package:movieapp/app/data_model/popular_ppl_local.dart';
import 'package:movieapp/app/locator.dart';
import 'package:movieapp/core/constant/const.dart';
import 'package:movieapp/core/utility/db.dart';
import 'package:movieapp/ui/shared/toast/show_toast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as devtools;

class PopularPplDBRepository {
  DataBase dbInstance = locator<DataBase>();

  Future<void> addPopularPerson(PopularPersonDB popularPerson) async {
    final db = await dbInstance.database;
    await db.insert(Constant.popularPplTName, popularPerson.toJson());
  }

  Future<void> savePopularPersonImage(String url) async {
    // save image locally in your device
    // first download the image using dio
    // get the image directory and generate a local path
    // then use gallery saver package to save image to targeted path at specified gallery
    Directory tempDir = await getTemporaryDirectory();
    String path = '${tempDir.path}/myImg.jpg';
    await Dio().download(url, path);
    await GallerySaver.saveImage(path, albumName: 'PopularPpl');
    showToast(message: 'image downloaded !');
  }

  Future<List<PopularPersonDB>> readAllPopularPpl() async {
    final db = await dbInstance.database;
    final mapList = await db.query(Constant.popularPplTName);
    devtools.log('popular persons map: ${mapList.toString()}');
    return mapList.map((e) => PopularPersonDB.fromJson(e)).toList();
  }
}
