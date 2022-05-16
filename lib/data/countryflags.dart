// Json
// Commande a executer pour generer "... .g.dart -> flutter packages pub run build_runner build

import 'package:json_annotation/json_annotation.dart';

part 'countryflags.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryFlags {

  String? svg;
  String? png;

  CountryFlags({
    this.svg,
    this.png,
  });

  factory CountryFlags.fromJson(Map<String,dynamic> data) => _$CountryFlagsFromJson(data);

  Map<String,dynamic> toJson() => _$CountryFlagsToJson(this);

}
