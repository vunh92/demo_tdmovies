import 'package:demo_tdmovies/features/discover/data/models/strings.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/domain/production_companies.dart';

class ProductionCompaniesModel extends ProductionCompanies {
  ProductionCompaniesModel({
    id,
    logoPath,
    name,
    originCountry,
  }) : super (
    id: id,
    logoPath: logoPath,
    name: name,
    originCountry: originCountry,
  );

  factory ProductionCompaniesModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompaniesModel(
      id: json['id'],
      logoPath: MyStrings.apiImage + (json['logo_path'] ?? ''),
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }
}