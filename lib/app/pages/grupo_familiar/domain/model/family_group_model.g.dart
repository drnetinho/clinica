// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyGroupModel _$FamilyGroupModelFromJson(Map json) => FamilyGroupModel(
      json['id'] as String,
      json['name'] as String,
      (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      (json['payments'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FamilyGroupModelToJson(FamilyGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'members': instance.members,
      'payments': instance.payments,
    };
