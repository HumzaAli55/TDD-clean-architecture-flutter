import 'dart:convert';

import 'package:mock_api_practice/feature/home/domain/entities/home.dart';

List<CategoriesModel> homeModelFromJson(String str) => List<CategoriesModel>.from(json.decode(str).map((x) => CategoriesModel.fromJson(x)));

String homeModelToJson(List<CategoriesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel extends CategoriesEntity {
  @override
  final String name;
 final String slug;
 final String url;

  CategoriesModel({
    required this.slug,
    required this.name,
    required this.url,
  }) : super(name: name);

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    slug: json["slug"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "name": name,
    "url": url,
  };
}
