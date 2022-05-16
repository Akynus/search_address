// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      type: json['type'] as String,
      coordinates:
          Coordinate.fromJson(json['coordinates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
