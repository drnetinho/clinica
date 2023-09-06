extension StringValidators on String {
  bool get hasMinimumLength => length >= 6;
  bool get isMoreThanOne => length > 0;
  String? get hasError => hasMinimumLength ? null : '';
  String get lower => this.toLowerCase();

  bool  get isValidEmail {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
