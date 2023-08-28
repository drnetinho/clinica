import 'package:flutter/material.dart';
import 'package:netinhoappclinica/app/core/styles/colors_app.dart';
import 'package:netinhoappclinica/app/core/styles/text_app.dart';

class CardCategoriasWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  const CardCategoriasWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsApp.instance.backgroundCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(10),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 18, color: context.colorsApp.primaryColorGrean)),
                const SizedBox(width: 10),
                Icon(icon, color: context.colorsApp.primaryColorGrean, size: 24),
              ],
            ),
            const SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(subTitle, style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 14, color: context.colorsApp.textCardColor)),
            )
          ],
        ),
      ),
    );
  }
}
