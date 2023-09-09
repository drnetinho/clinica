import 'package:json_annotation/json_annotation.dart';

part 'family_payment_model.g.dart';

@JsonSerializable()
class FamilyPaymnetModel {
  final String id;
  final String familyGroupId;
  final double monthlyFee;
  final DateTime payDate;
  final bool pending;

  FamilyPaymnetModel(
    this.id,
    this.familyGroupId,
    this.monthlyFee,
    this.payDate,
    this.pending,
  );

  factory FamilyPaymnetModel.fromJson(Map<String, dynamic> json) => _$FamilyPaymnetModelFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyPaymnetModelToJson(this);

  FamilyPaymnetModel copyWith({
    String? id,
    String? familyGroupId,
    double? monthlyFee,
    DateTime? payDate,
    bool? pending,
  }) {
    return FamilyPaymnetModel(
      id ?? this.id,
      familyGroupId ?? this.familyGroupId,
      monthlyFee ?? this.monthlyFee,
      payDate ?? this.payDate,
      pending ?? this.pending,
    );
  }
}