import 'package:json_annotation/json_annotation.dart';

part 'home_total_user_transaction.g.dart';

@JsonSerializable()
class HomeTotalUserTransaction {
  @JsonKey(name: "transaction")
  int totalTransaction;
  @JsonKey(name: "user")
  int totalUser;

  HomeTotalUserTransaction({this.totalTransaction, this.totalUser});

  factory HomeTotalUserTransaction.fromJson(Map<String, dynamic> json) =>
      _$HomeTotalUserTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$HomeTotalUserTransactionToJson(this);
}