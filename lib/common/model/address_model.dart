import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final String city;
  final String neighborhood;
  final String number;
  final String state;
  final String street;

  AddressModel({
    required this.city,
    required this.neighborhood,
    required this.number,
    required this.state,
    required this.street,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  AddressModel copyWith({
    String? city,
    String? neighborhood,
    String? number,
    String? state,
    String? street,
  }) {
    return AddressModel(
      city: city ?? this.city,
      neighborhood: neighborhood ?? this.neighborhood,
      number: number ?? this.number,
      state: state ?? this.state,
      street: street ?? this.street,
    );
  }
}
