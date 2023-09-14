import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'family_group_model.g.dart';

@JsonSerializable()
class FamilyGroupModel extends Equatable {
  final String id;
  final String name;
  final List<String> members;
  final List<String> payments;
  final DateTime createdAt;

  const FamilyGroupModel(
    this.id,
    this.name,
    this.members,
    this.payments,
    this.createdAt,
  );

  const FamilyGroupModel.empty({
    this.id = '',
    this.name = '',
    required this.createdAt,
    this.members = const [],
    this.payments = const [],
  });

  factory FamilyGroupModel.fromJson(Map<String, dynamic> json) => _$FamilyGroupModelFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyGroupModelToJson(this);

  FamilyGroupModel copyWith({
    String? id,
    String? name,
    List<String>? members,
    List<String>? payments,
    DateTime? createdAt,
  }) {
    return FamilyGroupModel(
      id ?? this.id,
      name ?? this.name,
      members ?? this.members,
      payments ?? this.payments,
      createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      members,
      payments,
      createdAt,
    ];
  }
}
