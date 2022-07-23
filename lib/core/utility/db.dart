import 'package:movieapp/core/constant/const.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _createDB('DB71.db');
    return _database!;
  }

  Future<Database> _createDB(String dbFile) async {
    final dbDirectory = await getDatabasesPath();
    final finalDirec = join(dbDirectory, dbFile);
    return await openDatabase(finalDirec, version: 2, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute(
        ' CREATE TABLE ${Constant.popularPplTName} ( ${Constant.popularPplUnqId} ${Constant.popularPplUnqIdFType}, ${Constant.popularPplId} ${Constant.popularIdFType},${Constant.popularPplName} ${Constant.popularNameFType},${Constant.popularPplCareer} ${Constant.popularCareerFType},${Constant.popularPplGender} ${Constant.popularPplGenderFType})');

    // await db.execute(
    //     'CREATE TABLE ${Constant.savedImagesTName} ( ${Constant.imageId} ${Constant.imageIdFType},${Constant.imageFilePath} ${Constant.imageFilePathFType}) )');
  }

  Future? close() async {
    final db = await database;
    db.close();
  }
}
