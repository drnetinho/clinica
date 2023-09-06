import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:netinhoappclinica/common/state/app_state.dart';
import 'package:netinhoappclinica/core/components/state_widget.dart';

// T é o tipo de dado de sucesso
class StoreBuilder<T> extends StatefulWidget {
  final ValueListenable<AppState> store;
  final ValueWidgetBuilder<T> builder;
  final Widget? child;
  final bool validateEmptyList;
  final bool validateDefaultStates;

  const StoreBuilder({
    required this.store,
    required this.builder,
    this.child,
    this.validateEmptyList = false,
    this.validateDefaultStates = true,
    super.key,
  });

  @override
  State<StoreBuilder<T>> createState() => _StoreBuilderState<T>();
}

class _StoreBuilderState<T> extends State<StoreBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppState>(
      valueListenable: widget.store,
      child: widget.child,
      builder: (context, value, child) {
        if (widget.validateDefaultStates) {
          return switch (value) {
            AppStateSuccess(data: final data) => //
              Builder(
                builder: (context) {
                  if (widget.validateEmptyList && data is List && data.isEmpty) {
                    return const StateEmptyWidget();
                  } else {
                    return widget.builder(context, data, child);
                  }
                },
              ),
            AppStateError(error: final error) => //
              StateErrorWidget(message: error),
            AppStateInitial() => const StateInitialWidget(),
            AppStateLoading() => const StateLoadingWidget(),
          };
        } else if (value is AppStateSuccess) {
          return widget.builder(context, value.data, child);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
