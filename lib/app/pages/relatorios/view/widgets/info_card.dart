import 'package:flutter/material.dart';

import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../core/components/animated_resize.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String info;
  final bool isLoading;
  final IconData icon;

  const InfoCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.info,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedResize(
      child: PhysicalModel(
        elevation: 1,
        color: context.colorsApp.backgroundCardColor,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: context.textStyles.textPoppinsRegular
                        .copyWith(fontSize: 16, color: context.colorsApp.greyColor2),
                  ),
                  const SizedBox(width: 60),
                  Icon(
                    icon,
                    color: context.colorsApp.primary,
                    size: 20,
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text(
                info,
                style: context.textStyles.textPoppinsBold.copyWith(
                  fontSize: 20,
                  color: context.colorsApp.greyColor2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
