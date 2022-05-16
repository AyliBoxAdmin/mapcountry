// Json
// Commande a executer pour generer "... .g.dart -> flutter packages pub run build_runner build

import 'package:json_annotation/json_annotation.dart';

part 'countrycurrencies.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryCurrencies {

  String? code;
  String? name;
  String? symbol;

  CountryCurrencies({
    this.code,
    this.name,
    this.symbol,
  });

  factory CountryCurrencies.fromJson(Map<String,dynamic> data) => _$CountryCurrenciesFromJson(data);

  Map<String,dynamic> toJson() => _$CountryCurrenciesToJson(this);

}
