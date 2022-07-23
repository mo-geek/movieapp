import 'package:movieapp/core/constant/const.dart';

class PopularPersonDB {
  final int? id;
  final String? name;
  final String? career;
  final int? gender;

  PopularPersonDB({this.id, this.name, this.career, this.gender});
  static PopularPersonDB fromJson(Map<String, Object?> map) => PopularPersonDB(
        id: map[Constant.popularPplId] as int?,
        name: map[Constant.popularPplName] as String,
        career: map[Constant.popularPplCareer] as String,
        gender: map[Constant.popularPplGender] as int?,
      );

  Map<String, Object?> toJson() {
    var map = <String, Object?>{};
    map = {
      Constant.popularPplId: id,
      Constant.popularPplName: name,
      Constant.popularPplCareer: career,
      Constant.popularPplGender: gender,
    };
    return map;
  }
}
