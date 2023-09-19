import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/common/state/app_state.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/components/state_widget.dart';
import 'package:netinhoappclinica/core/styles/colors_app.dart';
import 'package:netinhoappclinica/core/styles/text_app.dart';

import '../enum/widget_state.dart';
import '../helps/spacing.dart';

class AppDialog extends StatefulWidget {
  final String title;
  final String? firstButtonText;
  final IconData? firstButtonIcon;
  final IconData? secondButtonIcon;
  final String? secondButtonText;
  final VoidCallback? onPressedFirst;
  final VoidCallback? onPressedSecond;
  final VoidCallback? actionOnSuccess;
  final ValueListenable<AppState> store;

  const AppDialog({
    Key? key,
    required this.title,
    this.firstButtonText,
    this.firstButtonIcon,
    this.secondButtonIcon,
    this.secondButtonText,
    this.onPressedFirst,
    this.actionOnSuccess,
    this.onPressedSecond,
    required this.store,
  }) : super(key: key);

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  @override
  void initState() {
    super.initState();
    widget.store.addListener(
      () {
        if (widget.store.value is AppStateSuccess) {
          widget.actionOnSuccess?.call();
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: AnimatedBuilder(
          animation: widget.store,
          builder: (context, _) {
            return Container(
              decoration: BoxDecoration(
                color: context.colorsApp.whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              height: 120,
              width: 470,
              //Todo olhar esse padding
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: switch (widget.store.value.widgetState) {
                  WidgetState.loading => //
                    const StateLoadingWidget(),
                  WidgetState.error => //
                    const StateErrorWidget(),
                  WidgetState.success ||
                  WidgetState.initial => //
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 16)),
                        Spacing.xm.verticalGap,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (widget.firstButtonText != null && widget.firstButtonIcon != null) ...{
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.colorsApp.dartWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: widget.onPressedFirst ?? context.pop,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(widget.firstButtonIcon!, color: context.colorsApp.greyColor2),
                                    const SizedBox(width: 6),
                                    Text(widget.firstButtonText!,
                                        style: context.textStyles.textPoppinsSemiBold
                                            .copyWith(color: context.colorsApp.softBlack)),
                                  ],
                                ),
                              ),
                            },
                            if (widget.secondButtonText != null && widget.secondButtonIcon != null) ...{
                              Spacing.m.horizotalGap,
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.colorsApp.danger,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: widget.onPressedSecond,
                                child: Row(
                                  children: [
                                    Icon(widget.secondButtonIcon!, color: context.colorsApp.whiteColor),
                                    const SizedBox(width: 6),
                                    Text(
                                      widget.secondButtonText!,
                                      style: context.textStyles.textPoppinsSemiBold
                                          .copyWith(color: context.colorsApp.whiteColor),
                                    ),
                                  ],
                                ),
                              ),
                            },
                          ],
                        ),
                      ],
                    ),
                },
              ),
            );
          }),
    );
  }
}
