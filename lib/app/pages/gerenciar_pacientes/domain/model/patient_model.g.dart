// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map<String, dynamic> json) => PatientModel(
      json['name'] as String,
      json['gender'] as String,
      json['familyGroup'] as String,
      AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      json['age'] as String,
      json['phone'] as String,
      (json['previousIlnesses'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'familyGroup': instance.familyGroup,
      'address': instance.address,
      'age': instance.age,
      'phone': instance.phone,
      'previousIlnesses': instance.previousIlnesses,
    };
