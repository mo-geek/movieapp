import 'package:flutter/cupertino.dart';

class Constant {
  // bearer token
  static const String authToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYjY2NjBmNzBkMzgyZWIwODg1ZWM5ZDhjNTZjOWQ0OCIsInN1YiI6IjYyZDZhMmFjMWYzZTYwMDk2NDEyODU1NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Rw9-60eqFyv4oGDQQqW4LJReTBC_96ppn6VdIu1Rz-Q';
  // api token
  static const String apiToken = 'ab6660f70d382eb0885ec9d8c56c9d48';

  // app domain
  static const String appUrl = 'https://api.themoviedb.org/3/';

  // app end points
  static const String popularPplEndP = '/person/popular';
  static const String popularPersonEndP = 'person/';

  // shared preferences keys
  static const String authTokenKey = 'auth_token_key';

  // base url && image size w185
  static const String baseUrlImgW185 = 'http://image.tmdb.org/t/p/w185/';
  static const String baseUrlImgOriginal =
      'http://image.tmdb.org/t/p/original/';

  static const TextStyle primaryTextStyle =
      TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis);
  // database table names
  static const String popularPplTName = 'PopularPerson';
  // static const String savedImagesTName = 'SavedImages';

  // db popular person table fields && fields types
  static const String popularPplUnqId = 'id';
  static const String popularPplUnqIdFType =
      'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String popularPplId = 'personId';
  static const String popularIdFType = 'INTEGER NULL';
  static const String popularPplName = 'personName';
  static const String popularNameFType = 'varchar(255) UNIQUE';
  static const String popularPplCareer = 'personCareer';
  static const String popularCareerFType = 'varchar(75)';
  static const String popularPplGender = 'gender';
  static const String popularPplGenderFType = 'INTEGER NULL';

  // db saved images table fields && fields types
  // static const String imageId = 'savedImageId';
  // static const String imageIdFType = 'int NOT NULL AUTO_INCREMENT';
  // static const String imageFilePath = 'savedFilePath';
  // static const String imageFilePathFType = 'varchar(255)';
}
