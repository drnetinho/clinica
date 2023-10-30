import 'package:clisp/core/styles/text_app.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/colors_app.dart';

class AvaliationSelectorCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AvaliationSelectorCard({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorsApp.instance.greyColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_add),
            Text(
              title,
              style: context.textStyles.textPoppinsMedium.copyWith(
                fontSize: 12,
                color: ColorsApp.instance.greyColor2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
