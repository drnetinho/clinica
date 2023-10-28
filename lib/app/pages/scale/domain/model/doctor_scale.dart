import 'package:json_annotation/json_annotation.dart';

part 'doctor_scale.g.dart';

@JsonSerializable()
class DoctorScale {
  final String doctorId;
  final String end;
  final String start;
  final String date;
  final String id;

  DateTime get dateTime => DateTime.parse(date);
  bool get isOlder =>dateTime.isBefore(DateTime.now());

  DoctorScale(
    this.doctorId,
    this.end,
    this.start,
    this.date,
    this.id,
  );

  factory DoctorScale.fromJson(Map<String, dynamic> json) => _$DoctorScaleFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorScaleToJson(this);

  static DoctorScale empty() => DoctorScale('', '', '', '', '');

  DoctorScale copyWith({
    String? doctorId,
    String? end,
    String? start,
    String? date,
    String? id,
  }) {
    return DoctorScale(
      doctorId ?? this.doctorId,
      end ?? this.end,
      start ?? this.start,
      date ?? this.date,
      id ?? this.id,
    );
  }
}
