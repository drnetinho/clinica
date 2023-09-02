import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../common/model/address_model.dart';

part 'patient_model.g.dart';

@JsonSerializable()
class PatientModel extends Equatable {
  final String name;
  final String gender;
  final String familyGroup;
  final AddressModel address;
  final String age;
  final String phone;
  final List<String> previousIlnesses;
  final String id;

  const PatientModel(
    this.name,
    this.gender,
    this.familyGroup,
    this.address,
    this.age,
    this.phone,
    this.previousIlnesses,
    this.id,
  );

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
      ];
}
