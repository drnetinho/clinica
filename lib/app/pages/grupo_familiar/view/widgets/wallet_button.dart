import 'package:flutter/material.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class WalletButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool enabled;
  const WalletButton({
    Key? key,
    required this.enabled,
    this.onTap,
  }) : super(key: key);

  Color get customColor => enabled ? ColorsApp.instance.success : ColorsApp.instance.greyColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 200,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: customColor, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 20, color: customColor),
            const SizedBox(width: 6),
            Text(
              'Ver Carteirinha',
              style: context.textStyles.textPoppinsMedium.copyWith(
                fontSize: 14,
                color: customColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
