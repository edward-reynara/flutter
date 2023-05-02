// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeApp _$HomeAppFromJson(Map<String, dynamic> json) {
  return HomeApp(
    id: json['id'] as int,
    name: json['name'] as String,
    logo: json['logo'] as String,
  );
}

Map<String, dynamic> _$HomeAppToJson(HomeApp instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };
