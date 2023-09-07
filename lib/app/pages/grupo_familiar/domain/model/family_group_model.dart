import 'package:json_annotation/json_annotation.dart';

part 'family_group_model.g.dart';

@JsonSerializable()
class FamilyGroupModel {
  final String id;
  final String name;
  final bool pending;
  final List<String> members;
  final double actualMonthlyFee;
  final DateTime actualPayDate;
  final List<String> payments;

  FamilyGroupModel(
    this.id,
    this.name,
    this.pending,
    this.members,
    this.actualMonthlyFee,
    this.actualPayDate,
    this.payments,
  );

  factory FamilyGroupModel.fromJson(Map<String, dynamic> json) => _$FamilyGroupModelFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyGroupModelToJson(this);

  FamilyGroupModel copyWith({
    String? id,
    String? name,
    bool? pending,
    List<String>? members,
    double? actualMonthlyFee,
    DateTime? actualPayDate,
    List<String>? payments,
  }) {
    return FamilyGroupModel(
      id ?? this.id,
      name ?? this.name,
      pending ?? this.pending,
      members ?? this.members,
      actualMonthlyFee ?? this.actualMonthlyFee,
      actualPayDate ?? this.actualPayDate,
      payments ?? this.payments,
    );
  }
}
