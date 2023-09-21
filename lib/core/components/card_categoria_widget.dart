import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class CardCategoriasWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final Color? background;

  const CardCategoriasWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.icon,
    this.width,
    this.height,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.25,
        height: height ?? MediaQuery.of(context).size.height * 0.2,
        child: PhysicalModel(
          color: background ?? ColorsApp.instance.backgroundCardColor,
          borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title,
                        style: context.textStyles.textPoppinsBold
                            .copyWith(fontSize: 24, color: context.colorsApp.success)),
                    const SizedBox(width: 20),
                    Icon(icon, color: context.colorsApp.success, size: 24),
                  ],
                ),
                const SizedBox(height: 10),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(subTitle,
                      style: context.textStyles.textPoppinsSemiBold
                          .copyWith(fontSize: 16, color: context.colorsApp.textCardColor)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
