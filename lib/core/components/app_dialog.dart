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
  final String? description;
  final String? firstButtonText;
  final IconData? firstButtonIcon;
  final IconData? secondButtonIcon;
  final IconData? thirdButtonIcon;
  final bool popOnSuccess;
  final String? secondButtonText;
  final String? thirdButtonText;
  final VoidCallback? onPressedFirst;
  final VoidCallback? onPressedSecond;
  final VoidCallback? onPressedThird;
  final VoidCallback? actionOnSuccess;
  final ValueListenable<AppState> store;
  final double? width;
  final double? height;
  final Color? firstButtonBackgroudColor;
  final Color? secondButtonBackgroudColor;
  final Color? thirdButtonBackgroudColor;

  const AppDialog({
    Key? key,
    required this.title,
    this.popOnSuccess = true,
    this.description,
    this.width,
    this.height,
    this.firstButtonText,
    this.firstButtonIcon,
    this.secondButtonIcon,
    this.thirdButtonIcon,
    this.secondButtonText,
    this.thirdButtonText,
    this.onPressedFirst,
    this.onPressedSecond,
    this.onPressedThird,
    this.actionOnSuccess,
    this.firstButtonBackgroudColor,
    this.secondButtonBackgroudColor,
    this.thirdButtonBackgroudColor,
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
        if (widget.store.value.isSuccess) {
          widget.actionOnSuccess?.call();
          if (widget.popOnSuccess) {
            context.pop();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: AnimatedBuilder(
          animation: widget.store,
          builder: (context, _) {
            return Container(
              decoration: BoxDecoration(
                color: context.colorsApp.whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              height: widget.height ?? (widget.description != null ? 180 : 140),
              width: widget.width ?? 470,
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
                        Spacing.m.verticalGap,
                        if (widget.description != null) ...{
                          Text(
                            widget.description!,
                            style: context.textStyles.textPoppinsSemiBold.copyWith(fontSize: 12),
                          ),
                        },
                        Spacing.xm.verticalGap,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (widget.firstButtonText != null && widget.firstButtonIcon != null) ...{
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.firstButtonBackgroudColor ?? context.colorsApp.whiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: widget.onPressedFirst ?? context.pop,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(widget.firstButtonIcon!, color: context.colorsApp.greyColor2, size: 16),
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
                                  backgroundColor: widget.secondButtonBackgroudColor ?? context.colorsApp.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: widget.onPressedSecond,
                                child: Row(
                                  children: [
                                    Icon(widget.secondButtonIcon!, color: context.colorsApp.whiteColor, size: 16),
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
                            if (widget.thirdButtonText != null && widget.thirdButtonIcon != null) ...{
                              Spacing.m.horizotalGap,
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.thirdButtonBackgroudColor ?? context.colorsApp.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: widget.onPressedThird,
                                child: Row(
                                  children: [
                                    Icon(widget.thirdButtonIcon!, color: context.colorsApp.whiteColor, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.thirdButtonText!,
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
