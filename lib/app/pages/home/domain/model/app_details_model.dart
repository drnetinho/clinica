import 'package:json_annotation/json_annotation.dart';

part 'app_details_model.g.dart';

@JsonSerializable()
class AppDetailsModel {
  final String address;
  final String name;
  final String phone1;
  final String? phone2;

  AppDetailsModel({
    required this.address,
    required this.name,
    required this.phone1,
    this.phone2,
  });

  factory AppDetailsModel.fromJson(Map<String, dynamic> json) => _$AppDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$AppDetailsModelToJson(this);
}
