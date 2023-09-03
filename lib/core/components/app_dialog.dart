import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netinhoappclinica/common/state/app_state.dart';
import 'package:netinhoappclinica/common/state/app_state_extension.dart';
import 'package:netinhoappclinica/core/components/state_widget.dart';

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
            return SizedBox(
              height: 120,
              width: 470,
              child: switch (widget.store.value.widgetState) {
                WidgetState.loading => //
                  const StateLoadingWidget(),
                WidgetState.error => //
                  const StateErrorWidget(),
                WidgetState.success ||
                WidgetState.initial => //
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.title),
                      Spacing.m.verticalGap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (widget.firstButtonText != null && widget.firstButtonIcon != null) ...{
                            ElevatedButton(
                              onPressed: widget.onPressedFirst ?? context.pop,
                              child: Row(
                                children: [
                                  Icon(widget.firstButtonIcon!),
                                  Text(widget.firstButtonText!),
                                ],
                              ),
                            ),
                          },
                          if (widget.secondButtonText != null && widget.secondButtonIcon != null) ...{
                            Spacing.m.horizotalGap,
                            ElevatedButton(
                              onPressed: widget.onPressedSecond,
                              child: Row(
                                children: [
                                  Icon(widget.secondButtonIcon!),
                                  Text(widget.secondButtonText!),
                                ],
                              ),
                            ),
                          },
                        ],
                      ),
                    ],
                  ),
              },
            );
          }),
    );
  }
}
