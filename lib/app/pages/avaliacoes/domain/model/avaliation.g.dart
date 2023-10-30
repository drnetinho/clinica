// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avaliation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Avaliation _$AvaliationFromJson(Map json) => Avaliation(
      json['id'] as String,
      json['alterado'] as bool,
      json['data'] as String,
      json['altura'] as String,
      json['peso'] as String,
      json['doctorId'] as String,
      json['patientId'] as String,
      json['frequenciaCardiaca'] as String,
      json['frequenciaRespiratoria'] as String,
      json['observacoes'] as String,
      json['pressaoArterial'] as String,
      (json['examesSolicitados'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AvaliationToJson(Avaliation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'alterado': instance.alterado,
      'data': instance.data,
      'altura': instance.altura,
      'peso': instance.peso,
      'doctorId': instance.doctorId,
      'patientId': instance.patientId,
      'frequenciaCardiaca': instance.frequenciaCardiaca,
      'frequenciaRespiratoria': instance.frequenciaRespiratoria,
      'observacoes': instance.observacoes,
      'pressaoArterial': instance.pressaoArterial,
      'examesSolicitados': instance.examesSolicitados,
    };
