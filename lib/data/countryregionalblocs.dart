// Json
// Commande a executer pour generer "... .g.dart -> flutter packages pub run build_runner build

import 'package:json_annotation/json_annotation.dart';

part 'countryregionalblocs.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryRegionalBlocs {

  String? acronym;
  String? name;

  CountryRegionalBlocs({
    this.acronym,
    this.name,
  });

  factory CountryRegionalBlocs.fromJson(Map<String,dynamic> data) => _$CountryRegionalBlocsFromJson(data);

  Map<String,dynamic> toJson() => _$CountryRegionalBlocsToJson(this);

}
