// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      cep: json['cep'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      neighborhood: json['neighborhood'] as String? ?? "",
      street: json['street'] as String? ?? "",
      service: json['service'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'cep': instance.cep,
      'state': instance.state,
      'city': instance.city,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
      'service': instance.service,
      'location': instance.location,
    };
