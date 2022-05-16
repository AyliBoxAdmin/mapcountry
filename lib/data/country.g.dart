// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      id: json['id'] as String?,
      name: json['name'] as String,
      topLevelDomain: (json['topLevelDomain'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      alpha2Code: json['alpha2Code'] as String?,
      alpha3Code: json['alpha3Code'] as String?,
      callingCodes: (json['callingCodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      capital: json['capital'] as String?,
      altSpellings: (json['altSpellings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subregion: json['subregion'] as String?,
      region: json['region'] as String?,
      population: json['population'] as int?,
      latlng: (json['latlng'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      demonym: json['demonym'] as String?,
      area: (json['area'] as num?)?.toDouble(),
      timezones: (json['timezones'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      borders:
          (json['borders'] as List<dynamic>?)?.map((e) => e as String).toList(),
      nativeName: json['nativeName'] as String?,
      numericCode: json['numericCode'] as String?,
      flags: json['flags'] == null
          ? null
          : CountryFlags.fromJson(json['flags'] as Map<String, dynamic>),
      currencies: (json['currencies'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CountryCurrencies.fromJson(e as Map<String, dynamic>))
          .toList(),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CountryLanguages.fromJson(e as Map<String, dynamic>))
          .toList(),
      translations: json['translations'] == null
          ? null
          : CountryTranslations.fromJson(
              json['translations'] as Map<String, dynamic>),
      flag: json['flag'] as String?,
      regionalBlocs: (json['regionalBlocs'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CountryRegionalBlocs.fromJson(e as Map<String, dynamic>))
          .toList(),
      cioc: json['cioc'] as String?,
      independent: json['independent'] as bool?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'topLevelDomain': instance.topLevelDomain,
      'alpha2Code': instance.alpha2Code,
      'alpha3Code': instance.alpha3Code,
      'callingCodes': instance.callingCodes,
      'capital': instance.capital,
      'altSpellings': instance.altSpellings,
      'subregion': instance.subregion,
      'region': instance.region,
      'population': instance.population,
      'latlng': instance.latlng,
      'demonym': instance.demonym,
      'area': instance.area,
      'timezones': instance.timezones,
      'borders': instance.borders,
      'nativeName': instance.nativeName,
      'numericCode': instance.numericCode,
      'flags': instance.flags?.toJson(),
      'currencies': instance.currencies?.map((e) => e?.toJson()).toList(),
      'languages': instance.languages?.map((e) => e?.toJson()).toList(),
      'translations': instance.translations?.toJson(),
      'flag': instance.flag,
      'regionalBlocs': instance.regionalBlocs?.map((e) => e?.toJson()).toList(),
      'cioc': instance.cioc,
      'independent': instance.independent,
    };
