// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map json) => AddressModel(
      json['city'] as String,
      json['neighborhood'] as String,
      json['number'] as String,
      json['state'] as String,
      json['street'] as String,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'neighborhood': instance.neighborhood,
      'number': instance.number,
      'state': instance.state,
      'street': instance.street,
    };
