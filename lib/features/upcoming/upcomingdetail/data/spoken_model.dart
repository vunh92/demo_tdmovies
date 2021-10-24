import 'package:demo_tdmovies/features/upcoming/upcomingdetail/domain/spoken.dart';

class SpokenModel extends Spoken {

  SpokenModel({
    englishName,
    iso,
    name
  }) : super(
      englishName: englishName,
      iso: iso,
      name: name
  );

  factory SpokenModel.fromJson(Map<String, dynamic> json) {
    return SpokenModel(
      englishName: json['english_name'],
      iso: json['iso_639_1'],
      name: json['name'],
    );
  }
}