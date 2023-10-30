import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'avaliation.g.dart';

@JsonSerializable()
class Avaliation extends Equatable {
  final String id;
  final bool alterado;
  final String data;
  final String altura;
  final String peso;
  final String doctorId;
  final String patientId;
  final String frequenciaCardiaca;
  final String frequenciaRespiratoria;
  final String observacoes;
  final String pressaoArterial;
  final List<String> examesSolicitados;

  const Avaliation(
    this.id,
    this.alterado,
    this.data,
    this.altura,
    this.peso,
    this.doctorId,
    this.patientId,
    this.frequenciaCardiaca,
    this.frequenciaRespiratoria,
    this.observacoes,
    this.pressaoArterial,
    this.examesSolicitados,
  );

  factory Avaliation.fromJson(Map<String, dynamic> json) => _$AvaliationFromJson(json);
  Map<String, dynamic> toJson() => _$AvaliationToJson(this);

  Avaliation copyWith({
    String? id,
    bool? alterado,
    String? data,
    String? altura,
    String? peso,
    String? doctorId,
    String? patientId,
    String? frequenciaCardiaca,
    String? frequenciaRespiratoria,
    String? observacoes,
    String? pressaoArterial,
    List<String>? examesSolicitados,
  }) {
    return Avaliation(
      id ?? this.id,
      alterado ?? this.alterado,
      data ?? this.data,
      altura ?? this.altura,
      peso ?? this.peso,
      doctorId ?? this.doctorId,
      patientId ?? this.patientId,
      frequenciaCardiaca ?? this.frequenciaCardiaca,
      frequenciaRespiratoria ?? this.frequenciaRespiratoria,
      observacoes ?? this.observacoes,
      pressaoArterial ?? this.pressaoArterial,
      examesSolicitados ?? this.examesSolicitados,
    );
  }

  @override
  List<Object?> get props => [
        id,
        alterado,
        data,
        altura,
        peso,
        doctorId,
        patientId,
        frequenciaCardiaca,
        frequenciaRespiratoria,
        observacoes,
        pressaoArterial,
        examesSolicitados,
      ];
}
