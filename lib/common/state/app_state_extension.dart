import 'package:netinhoappclinica/common/state/app_state.dart';

import '../../core/enum/widget_state.dart';

extension WidgetAppState on AppState {
  WidgetState get widgetState {
    return switch (this) {
      AppStateError() => WidgetState.error,
      AppStateInitial() => WidgetState.initial,
      AppStateLoading() => WidgetState.loading,
      AppStateSuccess() => WidgetState.success,
    };
  }

  bool get isLoading => this is AppStateLoading;
  bool get isError => this is AppStateError;
  bool get isSuccess => this is AppStateSuccess;
  bool get isInitial => this is AppStateInitial;
}
