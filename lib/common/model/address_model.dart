import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final String city;
  final String neighborhood;
  final String number;
  final String state;
  final String street;

  AddressModel(
    this.city,
    this.neighborhood,
    this.number,
    this.state,
    this.street,
  );

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  AddressModel copyWith({
    String? city,
    String? neighborhood,
    String? number,
    String? state,
    String? street,
  }) {
    return AddressModel(
      city ?? this.city,
      neighborhood ?? this.neighborhood,
      number ?? this.number,
      state ?? this.state,
      street ?? this.street,
    );
  }
}
