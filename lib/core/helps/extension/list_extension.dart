extension ListValidatorExtension on List? {
  bool get exists => this != null && this!.isNotEmpty;
  bool get noNull => this != null;
}
