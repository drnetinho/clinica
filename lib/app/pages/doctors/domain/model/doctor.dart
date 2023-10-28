import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  final String name;
  final String specialization;
  final String image;
  final String id;

  Doctor(
    this.name,
    this.specialization,
    this.image,
    this.id,
  );

  Doctor.empty() : this('', '', '', '');

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorToJson(this);

  Doctor copyWith({
    String? name,
    String? specialization,
    String? image,
    String? id,
  }) {
    return Doctor(
      name ?? this.name,
      specialization ?? this.specialization,
      image ?? this.image,
      id ?? this.id,
    );
  }
}
