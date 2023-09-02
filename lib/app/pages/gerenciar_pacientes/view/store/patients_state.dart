sealed class AppState {}

class AppStateSuccess<T> extends AppState {
  final T data;

  AppStateSuccess({
    required this.data,
  });
}

class AppStateError extends AppState {
  final String? error;
  AppStateError({this.error});
}

class AppStateLoading extends AppState {}

class AppStateInitial extends AppState {}



// sealed class ManagePatientsState {}
