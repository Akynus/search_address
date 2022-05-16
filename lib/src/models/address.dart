import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:search_address/src/models/location.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  Address({
    required this.cep,
    required this.state,
    required this.city,
    this.neighborhood = "",
    this.street = "",
    required this.service,
    required this.location,
  });

  @JsonKey(name: "cep")
  String cep;

  @JsonKey(name: "state")
  String state;

  @JsonKey(name: "city")
  String city;

  @JsonKey(name: "neighborhood")
  String neighborhood;

  @JsonKey(name: "street")
  String street;

  @JsonKey(name: "service")
  String service;

  @JsonKey(name: "location")
  Location location;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

class AddressApi{
  final Dio dio;

  AddressApi(this.dio);

  Future<Address> fetch(String zipCode) async {
    var response = await dio.get("https://brasilapi.com.br/api/cep/v2/$zipCode");
    return Address.fromJson(response.data);
  }
}
