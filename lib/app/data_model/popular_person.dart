class PopularPerson {
  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  String? birthday;
  String? deathday;
  int? gender;
  String? homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  double? popularity;
  String? profilePath;
  Images? images;

  PopularPerson(
      {adult,
      alsoKnownAs,
      biography,
      birthday,
      deathday,
      gender,
      homepage,
      id,
      imdbId,
      knownForDepartment,
      name,
      placeOfBirth,
      popularity,
      profilePath,
      images});

  PopularPerson.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    alsoKnownAs = json['also_known_as'].cast<String>();
    biography = json['biography'];
    birthday = json['birthday'];
    deathday = json['deathday'];
    gender = json['gender'];
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    placeOfBirth = json['place_of_birth'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    images = json['images'] != null ? Images.fromJson(json['images']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['also_known_as'] = alsoKnownAs;
    data['biography'] = biography;
    data['birthday'] = birthday;
    data['deathday'] = deathday;
    data['gender'] = gender;
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['place_of_birth'] = placeOfBirth;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    if (images != null) {
      data['images'] = images!.toJson();
    }
    return data;
  }
}

class Images {
  List<Profiles>? profiles;

  Images({profiles});

  Images.fromJson(Map<String, dynamic> json) {
    if (json['profiles'] != null) {
      profiles = <Profiles>[];
      json['profiles'].forEach((v) {
        profiles!.add(Profiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profiles != null) {
      data['profiles'] = profiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profiles {
  double? aspectRatio;
  int? height;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Profiles(
      {aspectRatio, height, iso6391, filePath, voteAverage, voteCount, width});

  Profiles.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aspect_ratio'] = aspectRatio;
    data['height'] = height;
    data['iso_639_1'] = iso6391;
    data['file_path'] = filePath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['width'] = width;
    return data;
  }
}
