// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyPaymnetModel _$FamilyPaymnetModelFromJson(Map json) => FamilyPaymnetModel(
      json['id'] as String,
      json['familyGroupId'] as String,
      (json['monthlyFee'] as num).toDouble(),
      DateTime.parse(json['payDate'] as String),
      json['receiveDate'] == null
          ? null
          : DateTime.parse(json['receiveDate'] as String),
      json['pending'] as bool,
      DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$FamilyPaymnetModelToJson(FamilyPaymnetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'familyGroupId': instance.familyGroupId,
      'monthlyFee': instance.monthlyFee,
      'payDate': instance.payDate.toIso8601String(),
      'receiveDate': instance.receiveDate?.toIso8601String(),
      'pending': instance.pending,
      'createdAt': instance.createdAt.toIso8601String(),
    };
