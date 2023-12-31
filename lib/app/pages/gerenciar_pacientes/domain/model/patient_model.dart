import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/model/address_model.dart';

part 'patient_model.g.dart';

@JsonSerializable()
class PatientModel extends Equatable {
  final String name;
  final String gender;
  final String familyGroup;
  final AddressModel? address;
  final String age;
  final String phone;
  final List<String>? previousIlnesses;
  final List<String>? avaliations;
  final String id;
  final String cpf;
  final DateTime createdAt;

  const PatientModel(
    this.name,
    this.gender,
    this.familyGroup,
    this.address,
    this.age,
    this.phone,
    this.previousIlnesses,
    this.avaliations,
    this.id,
    this.cpf,
    this.createdAt,
  );

  const PatientModel.initial({
    this.name = '',
    this.gender = '',
    this.familyGroup = '',
    this.address,
    this.age = '',
    this.phone = '',
    this.previousIlnesses,
    this.avaliations,
    this.id = '',
    this.cpf = '',
    required this.createdAt,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => _$PatientModelFromJson(json);
  Map<String, dynamic> toJson() => _$PatientModelToJson(this);

  @override
  List<Object?> get props => [
        name,
        gender,
        familyGroup,
        address,
        age,
        phone,
        previousIlnesses,
        id,
        cpf,
        createdAt,
        avaliations,
      ];

  PatientModel copyWith({
    String? name,
    String? gender,
    String? familyGroup,
    AddressModel? address,
    String? age,
    String? phone,
    List<String>? previousIlnesses,
    List<String>? avaliations,
    String? id,
    String? cpf,
    DateTime? createdAt,
  }) {
    return PatientModel(
      name ?? this.name,
      gender ?? this.gender,
      familyGroup ?? this.familyGroup,
      address ?? this.address,
      age ?? this.age,
      phone ?? this.phone,
      previousIlnesses ?? this.previousIlnesses,
      avaliations ?? this.avaliations,
      id ?? this.id,
      cpf ?? this.cpf,
      createdAt ?? this.createdAt,
    );
  }
}
