// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppDetailsModel _$AppDetailsModelFromJson(Map json) => AppDetailsModel(
      address: json['address'] as String,
      name: json['name'] as String,
      phone1: json['phone1'] as String,
      phone2: json['phone2'] as String,
    );

Map<String, dynamic> _$AppDetailsModelToJson(AppDetailsModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'phone1': instance.phone1,
      'phone2': instance.phone2,
    };
