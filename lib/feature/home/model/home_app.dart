import 'package:json_annotation/json_annotation.dart';

part 'home_app.g.dart';

@JsonSerializable()
class HomeApp {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "logo")
  final String logo;

  HomeApp({this.id, this.name, this.logo});

  factory HomeApp.fromJson(Map<String, dynamic> json) =>
      _$HomeAppFromJson(json);

  Map<String, dynamic> toJson() => _$HomeAppToJson(this);

}
