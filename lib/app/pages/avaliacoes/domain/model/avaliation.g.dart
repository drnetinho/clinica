// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avaliation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Avaliation _$AvaliationFromJson(Map json) => Avaliation(
      id: json['id'] as String,
      alterado: json['alterado'] as bool,
      data: json['data'] as String,
      altura: json['altura'] as String?,
      peso: json['peso'] as String?,
      doctorId: json['doctorId'] as String,
      patientId: json['patientId'] as String,
      frequenciaCardiaca: json['frequenciaCardiaca'] as String?,
      frequenciaRespiratoria: json['frequenciaRespiratoria'] as String?,
      observacoes: json['observacoes'] as String?,
      pressaoArterial: json['pressaoArterial'] as String?,
      examesSolicitados: (json['examesSolicitados'] as List<dynamic>)
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
