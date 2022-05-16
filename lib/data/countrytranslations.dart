// Json
// Commande a executer pour generer "... .g.dart -> flutter packages pub run build_runner build

import 'package:json_annotation/json_annotation.dart';

part 'countrytranslations.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryTranslations {

  String? br;
  String? pt;
  String? nl;
  String? hr;
  String? fa;
  String? de;
  String? es;
  String? fr;
  String? ja;
  String? it;
  String? hu;

  CountryTranslations({
    this.br,
    this.pt,
    this.nl,
    this.hr,
    this.fa,
    this.de,
    this.es,
    this.fr,
    this.ja,
    this.it,
    this.hu,
  });

  factory CountryTranslations.fromJson(Map<String,dynamic> data) => _$CountryTranslationsFromJson(data);

  Map<String,dynamic> toJson() => _$CountryTranslationsToJson(this);

}
