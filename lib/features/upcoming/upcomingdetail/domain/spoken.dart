import 'package:equatable/equatable.dart';

class Spoken extends Equatable {
  final String englishName;
  final String iso;
  final String name;

  Spoken({
    this.englishName,
    this.iso,
    this.name
  });

  @override
  // TODO: implement props
  List<Object> get props => [
    englishName,
    iso,
    name
  ];

}