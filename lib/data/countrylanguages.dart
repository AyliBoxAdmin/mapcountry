// Json
// Commande a executer pour generer "... .g.dart -> flutter packages pub run build_runner build

import 'package:json_annotation/json_annotation.dart';

part 'countrylanguages.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryLanguages {

  String? iso639_1;
  String? iso639_2;
  String? name;
  String? nativeName;

  CountryLanguages({
    this.iso639_1,
    this.iso639_2,
    this.name,
    this.nativeName,
  });

  factory CountryLanguages.fromJson(Map<String,dynamic> data) => _$CountryLanguagesFromJson(data);

  Map<String,dynamic> toJson() => _$CountryLanguagesToJson(this);

}
