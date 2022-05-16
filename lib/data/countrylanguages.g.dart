// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countrylanguages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryLanguages _$CountryLanguagesFromJson(Map<String, dynamic> json) =>
    CountryLanguages(
      iso639_1: json['iso639_1'] as String?,
      iso639_2: json['iso639_2'] as String?,
      name: json['name'] as String?,
      nativeName: json['nativeName'] as String?,
    );

Map<String, dynamic> _$CountryLanguagesToJson(CountryLanguages instance) =>
    <String, dynamic>{
      'iso639_1': instance.iso639_1,
      'iso639_2': instance.iso639_2,
      'name': instance.name,
      'nativeName': instance.nativeName,
    };
