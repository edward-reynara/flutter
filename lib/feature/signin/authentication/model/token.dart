import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: "token")
  String token;

  Token({String token});

  factory Token.fromjson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

//  factory Token.fromMap(Map<String, dynamic> map) => _$TokenFromMap(map);
//
//  Map<String, dynamic> toMap() => _$TokenToMap(this);
}
