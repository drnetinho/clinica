// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pix_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PixModel _$PixModelFromJson(Map json) => PixModel(
      json['id'] as String,
      json['name'] as String,
      json['bank'] as String,
      json['pixKey'] as String,
      json['typeKey'] as String,
      json['urlImage'] as String?,
    );

Map<String, dynamic> _$PixModelToJson(PixModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bank': instance.bank,
      'pixKey': instance.pixKey,
      'typeKey': instance.typeKey,
      'urlImage': instance.urlImage,
    };
