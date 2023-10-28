import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pix_model.g.dart';

@JsonSerializable()
class PixModel extends Equatable {
  final String id;
  final String name;
  final String bank;
  final String pixKey;
  final String typeKey;
  final String? urlImage;

  const PixModel(
    this.id,
    this.name,
    this.bank,
    this.pixKey,
    this.typeKey,
    this.urlImage,
  );

  const PixModel.initial({
    this.id = '',
    this.name = '',
    this.bank = '',
    this.pixKey = '',
    this.typeKey = '',
    this.urlImage = '',
  });

  factory PixModel.fromJson(Map<String, dynamic> json) => _$PixModelFromJson(json);
  Map<String, dynamic> toJson() => _$PixModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        bank,
        pixKey,
        typeKey,
        urlImage,
      ];

  PixModel copyWith({
    String? id,
    String? name,
    String? bank,
    String? pixKey,
    String? typeKey,
    String? urlImage,
  }) {
    return PixModel(
      id ?? this.id,
      name ?? this.name,
      bank ?? this.bank,
      pixKey ?? this.pixKey,
      typeKey ?? this.typeKey,
      urlImage ?? this.urlImage,
    );
  }
}
