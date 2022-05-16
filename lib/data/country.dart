// Json
// Commande a executer pour generer "... .g.dart -> flutter packages pub run build_runner build

import 'package:json_annotation/json_annotation.dart';

import 'countrycurrencies.dart';
import 'countryflags.dart';
import 'countrylanguages.dart';
import 'countryregionalblocs.dart';
import 'countrytranslations.dart';

part 'country.g.dart';

@JsonSerializable(explicitToJson: true)
class Country {

  String? id;
  final String name;
  List<String>? topLevelDomain;
  String? alpha2Code;
  String? alpha3Code;
  List<String>? callingCodes;
  String? capital;
  List<String>? altSpellings;
  String? subregion;
  String? region;
  int? population;
  List<double>? latlng;
  String? demonym;
  double? area;
  List<String>? timezones;
  List<String>? borders;
  String? nativeName;
  String? numericCode;

  CountryFlags? flags;
  List<CountryCurrencies?>? currencies;
  List<CountryLanguages?>? languages;
  CountryTranslations? translations;
  String? flag;
  List<CountryRegionalBlocs?>? regionalBlocs;
  String? cioc;
  bool? independent;

  Country({
    required this.id,
    required this.name,
    this.topLevelDomain,
    this.alpha2Code,
    this.alpha3Code,
    this.callingCodes,
    this.capital,
    this.altSpellings,
    this.subregion,
    this.region,
    this.population,
    this.latlng,
    this.demonym,
    this.area,
    this.timezones,
    this.borders,
    this.nativeName,
    this.numericCode,

    this.flags,
    this.currencies,
    this.languages,
    this.translations,
    this.flag,
    this.regionalBlocs,
    this.cioc,
    this.independent,

  });

  factory Country.fromJson(Map<String,dynamic> data) => _$CountryFromJson(data);

  Map<String,dynamic> toJson() => _$CountryToJson(this);


//------------------------------------------------------------------------------

/*
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'capital': this.capital,
      'latlng': this.latlng,
    };
  }

  factory Country.fromMap(int id, Map<String, dynamic> map) {
    return Country(
      //id: id.toString(),
      id: map['id'],
      name: map['name'],
      capital: map['capital'],
      latlng: map['latlng'],
    );
  }

  Country copyWith({String? id, String? name,String? capital,List<double>? latlng}){
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
      capital: capital ?? this.capital,
      latlng: latlng ?? this.latlng,
    );
  }
*/

}
