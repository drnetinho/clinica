import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'family_payment_model.g.dart';

@JsonSerializable(includeIfNull: true)
class FamilyPaymnetModel extends Equatable {
  final String id;
  final String familyGroupId;
  final double monthlyFee;
  final DateTime payDate;
  final DateTime? receiveDate;
  final bool pending;
  final DateTime createdAt;

  const FamilyPaymnetModel(
    this.id,
    this.familyGroupId,
    this.monthlyFee,
    this.payDate,
    this.receiveDate,
    this.pending,
    this.createdAt,
  );

  const FamilyPaymnetModel.empty({
    this.id = '',
    this.familyGroupId = '',
    this.monthlyFee = 0.0,
    required this.payDate,
    required this.createdAt,
    this.receiveDate,
    this.pending = true,
  });

  factory FamilyPaymnetModel.fromJson(Map<String, dynamic> json) => _$FamilyPaymnetModelFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyPaymnetModelToJson(this);

  FamilyPaymnetModel copyWith({
    String? id,
    String? familyGroupId,
    double? monthlyFee,
    DateTime? payDate,
    DateTime? receiveDate,
    bool? pending,
    DateTime? createdAt,
  }) {
    return FamilyPaymnetModel(
      id ?? this.id,
      familyGroupId ?? this.familyGroupId,
      monthlyFee ?? this.monthlyFee,
      payDate ?? this.payDate,
      receiveDate ?? this.receiveDate,
      pending ?? this.pending,
      createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      familyGroupId,
      monthlyFee,
      payDate,
      pending,
      createdAt,
    ];
  }
}
