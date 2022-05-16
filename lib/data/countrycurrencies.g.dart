// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countrycurrencies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryCurrencies _$CountryCurrenciesFromJson(Map<String, dynamic> json) =>
    CountryCurrencies(
      code: json['code'] as String?,
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$CountryCurrenciesToJson(CountryCurrencies instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
    };
