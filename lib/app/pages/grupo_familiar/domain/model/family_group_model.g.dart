// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyGroupModel _$FamilyGroupModelFromJson(Map json) => FamilyGroupModel(
      json['id'] as String,
      json['name'] as String,
      json['pending'] as bool,
      (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      (json['actualMonthlyFee'] as num).toDouble(),
      DateTime.parse(json['actualPayDate'] as String),
      (json['payments'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FamilyGroupModelToJson(FamilyGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pending': instance.pending,
      'members': instance.members,
      'actualMonthlyFee': instance.actualMonthlyFee,
      'actualPayDate': instance.actualPayDate.toIso8601String(),
      'payments': instance.payments,
    };
