// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientModel _$PatientModelFromJson(Map json) => PatientModel(
      json['name'] as String,
      json['gender'] as String,
      json['familyGroup'] as String,
      json['address'] == null
          ? null
          : AddressModel.fromJson(
              Map<String, dynamic>.from(json['address'] as Map)),
      json['age'] as String,
      json['phone'] as String,
      (json['previousIlnesses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['id'] as String,
      json['cpf'] as String,
    );

Map<String, dynamic> _$PatientModelToJson(PatientModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'familyGroup': instance.familyGroup,
      'address': instance.address?.toJson(),
      'age': instance.age,
      'phone': instance.phone,
      'previousIlnesses': instance.previousIlnesses,
      'id': instance.id,
      'cpf': instance.cpf,
    };
