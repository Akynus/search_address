import 'package:json_annotation/json_annotation.dart';

part 'coordinate.g.dart';

@JsonSerializable()
class Coordinate {
  Coordinate({
    this.latitude,
    this.longitude,
  });

  @JsonKey(name: "latitude")
  String? latitude;

  @JsonKey(name: "longitude")
  String? longitude;

  factory Coordinate.fromJson(Map<String, dynamic> json) => _$CoordinateFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateToJson(this);
}
