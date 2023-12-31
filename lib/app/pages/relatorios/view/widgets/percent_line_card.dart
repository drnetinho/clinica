import 'package:flutter/material.dart';

import 'package:clisp/app/pages/relatorios/view/widgets/percent_info_text.dart';
import 'package:clisp/core/helps/extension/double_extension.dart';
import 'package:clisp/core/helps/extension/string_extension.dart';
import 'package:clisp/core/styles/colors_app.dart';
import 'package:clisp/core/styles/text_app.dart';

import '../../../../../core/components/animated_resize.dart';
import 'line_progress_indicator.dart';

class PercentLineCard extends StatefulWidget {
  final bool isLoading;
  final int total;
  final int pending;
  final int receive;
  const PercentLineCard({
    Key? key,
    required this.isLoading,
    required this.total,
    required this.pending,
    required this.receive,
  }) : super(key: key);

  @override
  State<PercentLineCard> createState() => _PercentLineCardState();
}

class _PercentLineCardState extends State<PercentLineCard> {
  double get pendingPercent => widget.pending / widget.total;
  double get receivePercent => widget.receive / widget.total;

  @override
  Widget build(BuildContext context) {
    return AnimatedResize(
      child: PhysicalModel(
        elevation: 1,
        color: context.colorsApp.backgroundCardColor,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              PercentInfoText(
                pendingPercent: pendingPercent.toPercent,
                receivePercent: receivePercent.toPercent,
              ),
              const SizedBox(height: 20),
              LineProgressIndicator(
                color: context.colorsApp.greenColor,
                backgroundColor: context.colorsApp.yellowColor,
                percent: receivePercent,
                borderRadius: BorderRadius.circular(12),
                height: MediaQuery.of(context).size.height * .07,
                width: MediaQuery.of(context).size.width * .40,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Grupo'.formatPlural(widget.receive),
                    style: context.textStyles.textPoppinsMedium
                        .copyWith(fontSize: 20, color: context.colorsApp.greyColor2),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * .16),
                  Text(
                    'Grupo'.formatPlural(widget.pending),
                    style: context.textStyles.textPoppinsMedium
                        .copyWith(fontSize: 20, color: context.colorsApp.greyColor2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
