// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_scale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorScale _$DoctorScaleFromJson(Map json) => DoctorScale(
      json['doctorId'] as String,
      json['end'] as String,
      json['start'] as String,
      json['date'] as String,
      json['id'] as String,
    );

Map<String, dynamic> _$DoctorScaleToJson(DoctorScale instance) =>
    <String, dynamic>{
      'doctorId': instance.doctorId,
      'end': instance.end,
      'start': instance.start,
      'date': instance.date,
      'id': instance.id,
    };
