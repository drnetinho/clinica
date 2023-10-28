import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

class ImageLogoMobile extends StatefulWidget {
  const ImageLogoMobile({
    super.key,
  });

  @override
  State<ImageLogoMobile> createState() => _ImageLogoMobileState();
}

class _ImageLogoMobileState extends State<ImageLogoMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Área do Paciente',
          style: context.textStyles.textPoppinsSemiBold.copyWith(
            color: context.colorsApp.blackColor,
            fontSize: 20,
          ),
        ),
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/doctor.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
