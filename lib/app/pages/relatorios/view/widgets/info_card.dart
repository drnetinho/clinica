import 'package:flutter/material.dart';

import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/components/animated_resize.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String info;
  final bool isLoading;

  const InfoCard({
    Key? key,
    required this.title,
    required this.info,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedResize(
      child: Card(
        color: context.colorsApp.backgroundCardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 1,
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
                  Icon(Icons.family_restroom, color: context.colorsApp.greyColor2, size: 20)
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
