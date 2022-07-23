class PopularPpl {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  PopularPpl({page, results, totalPages, totalResults});

  PopularPpl.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Results {
  bool? adult;
  int? gender;
  int? id;
  List<KnownFor>? knownFor;
  String? knownForDepartment;
  String? name;
  double? popularity;
  String? profilePath;

  Results(
      {adult,
      gender,
      id,
      knownFor,
      knownForDepartment,
      name,
      popularity,
      profilePath});

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    if (json['known_for'] != null) {
      knownFor = <KnownFor>[];
      json['known_for'].forEach((v) {
        knownFor!.add(KnownFor.fromJson(v));
      });
    }
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    if (knownFor != null) {
      data['known_for'] = knownFor!.map((v) => v.toJson()).toList();
    }
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    return data;
  }
}

class KnownFor {
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? mediaType;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  String? posterPath;
  num? voteAverage;
  int? voteCount;
  bool? adult;
  String? originalTitle;
  String? releaseDate;
  String? title;
  bool? video;

  KnownFor(
      {backdropPath,
      firstAirDate,
      genreIds,
      id,
      mediaType,
      name,
      originCountry,
      originalLanguage,
      originalName,
      overview,
      posterPath,
      voteAverage,
      voteCount,
      adult,
      originalTitle,
      releaseDate,
      title,
      video});

  KnownFor.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    firstAirDate = json['first_air_date'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    mediaType = json['media_type'];
    name = json['name'];
    originCountry = json['origin_country'] == null
        ? []
        : json['origin_country'].cast<String>();
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    adult = json['adult'];
    originalTitle = json['original_title'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backdrop_path'] = backdropPath;
    data['first_air_date'] = firstAirDate;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['media_type'] = mediaType;
    data['name'] = name;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['adult'] = adult;
    data['original_title'] = originalTitle;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    return data;
  }
}
