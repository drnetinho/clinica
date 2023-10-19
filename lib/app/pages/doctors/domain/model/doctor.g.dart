// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map json) => Doctor(
      json['name'] as String,
      json['specialization'] as String,
      json['image'] as String,
      json['id'] as String,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'name': instance.name,
      'specialization': instance.specialization,
      'image': instance.image,
      'id': instance.id,
    };
