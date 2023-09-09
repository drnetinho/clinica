import 'package:flutter/material.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../../../../../core/styles/colors_app.dart';

class WalletButton extends StatelessWidget {
  final VoidCallback onTap;
  const WalletButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: ColorsApp.instance.success, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 20, color: ColorsApp.instance.success),
            const SizedBox(width: 6),
            Text(
              'Ver Carteirinha',
              style: context.textStyles.textPoppinsMedium.copyWith(
                fontSize: 14,
                color: ColorsApp.instance.success,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
