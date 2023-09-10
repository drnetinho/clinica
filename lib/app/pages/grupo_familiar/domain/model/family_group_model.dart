import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'family_group_model.g.dart';

@JsonSerializable()
class FamilyGroupModel extends Equatable {
  final String id;
  final String name;
  final List<String> members;
  final List<String> payments;

  const FamilyGroupModel(
    this.id,
    this.name,
    this.members,
    this.payments,
  );

  factory FamilyGroupModel.fromJson(Map<String, dynamic> json) => _$FamilyGroupModelFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyGroupModelToJson(this);

  FamilyGroupModel copyWith({
    String? id,
    String? name,
    List<String>? members,
    List<String>? payments,
  }) {
    return FamilyGroupModel(
      id ?? this.id,
      name ?? this.name,
      members ?? this.members,
      payments ?? this.payments,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      members,
      payments,
    ];
  }
}
