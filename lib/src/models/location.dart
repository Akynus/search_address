import 'package:json_annotation/json_annotation.dart';
import 'package:search_address/src/models/coordinate.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  @JsonKey(name: "type")
  String type;

  @JsonKey(name: "coordinates")
  Coordinate coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
