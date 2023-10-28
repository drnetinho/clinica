import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class CardCategoriasWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData? icon;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final Color? background;

  const CardCategoriasWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
    this.icon,
    this.width,
    this.height,
    this.background,
  });

  double getHeigth(BuildContext context) {
    // A altura nao pode ser menor que 150
    if (MediaQuery.of(context).size.height * 0.17 < 150) {
      return 150;
    } else {
      return MediaQuery.of(context).size.height * 0.17;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.25,
      height: height ?? getHeigth(context),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        shape: BoxShape.rectangle,
        elevation: 3,
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: background ?? ColorsApp.instance.dartWhite,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: context.textStyles.textPoppinsBold.copyWith(
                            fontSize: 18,
                            color: context.colorsApp.success,
                          ),
                          maxLines: 3,
                        ),
                      ),
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
      ),
    );
  }
}
