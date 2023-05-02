// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_total_user_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeTotalUserTransaction _$HomeTotalUserTransactionFromJson(
    Map<String, dynamic> json) {
  return HomeTotalUserTransaction(
    totalTransaction: json['transaction'] as int,
    totalUser: json['user'] as int,
  );
}

Map<String, dynamic> _$HomeTotalUserTransactionToJson(
        HomeTotalUserTransaction instance) =>
    <String, dynamic>{
      'transaction': instance.totalTransaction,
      'user': instance.totalUser,
    };
