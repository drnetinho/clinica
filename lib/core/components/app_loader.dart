import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';

class AppLoader extends StatelessWidget {
  final double? size;
  final Color? color;
  final bool primary;
  const AppLoader({
    Key? key,
    this.size,
    this.color,
    this.primary = true,
  }) : super(key: key);

  Color get _color => color ?? (primary ? ColorsApp.instance.primary : ColorsApp.instance.whiteColor);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: _color,
      ),
    );
  }
}
