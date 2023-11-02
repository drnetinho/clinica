import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'avaliation.g.dart';

@JsonSerializable()
class Avaliation extends Equatable {
  final String id;
  final bool alterado;
  final String data;
  final String? altura;
  final String? peso;
  final String doctorId;
  final String patientId;
  final String? frequenciaCardiaca;
  final String? frequenciaRespiratoria;
  final String? observacoes;
  final String? pressaoArterial;
  final List<String> examesSolicitados;

  const Avaliation({
    required this.id,
    required this.alterado,
    required this.data,
    this.altura,
    this.peso,
    required this.doctorId,
    required this.patientId,
    this.frequenciaCardiaca,
    this.frequenciaRespiratoria,
    this.observacoes,
    this.pressaoArterial,
    required this.examesSolicitados,
  });

  factory Avaliation.fromJson(Map<String, dynamic> json) => _$AvaliationFromJson(json);
  Map<String, dynamic> toJson() => _$AvaliationToJson(this);

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
      id: id ?? this.id,
      alterado: alterado ?? this.alterado,
      data: data ?? this.data,
      altura: altura ?? this.altura,
      peso: peso ?? this.peso,
      doctorId: doctorId ?? this.doctorId,
      patientId: patientId ?? this.patientId,
      frequenciaCardiaca: frequenciaCardiaca ?? this.frequenciaCardiaca,
      frequenciaRespiratoria: frequenciaRespiratoria ?? this.frequenciaRespiratoria,
      observacoes: observacoes ?? this.observacoes,
      pressaoArterial: pressaoArterial ?? this.pressaoArterial,
      examesSolicitados: examesSolicitados ?? this.examesSolicitados,
    );
  }
}
