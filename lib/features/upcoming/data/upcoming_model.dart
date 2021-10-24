
import 'package:demo_tdmovies/features/discover/data/models/strings.dart';
import 'package:demo_tdmovies/features/upcoming/domain/upcoming.dart';

class UpcomingModel extends Upcoming{
  UpcomingModel({
    posterArtUrl,
    id,
    originalTitle,
  }) : super(
      posterArtUrl: posterArtUrl,
      id: id,
      originalTitle: originalTitle,
  );

  factory UpcomingModel.fromJson(Map<String, dynamic> json) {
    return UpcomingModel(
      posterArtUrl: MyStrings.apiImage + json['poster_path'],
      id: json['id'],
      originalTitle: json['original_title'],
    );
  }
}