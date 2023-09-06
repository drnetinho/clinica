// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map json) => AddressModel(
      city: json['city'] as String,
      neighborhood: json['neighborhood'] as String,
      number: json['number'] as String,
      state: json['state'] as String,
      street: json['street'] as String,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'neighborhood': instance.neighborhood,
      'number': instance.number,
      'state': instance.state,
      'street': instance.street,
    };
