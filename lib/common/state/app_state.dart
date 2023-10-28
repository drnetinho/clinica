sealed class AppState {}

class AppStateSuccess<T> extends AppState {
  final T data;

  AppStateSuccess({
    required this.data,
  });
}

class AppStateError extends AppState {
  final String message;
  AppStateError({ required this.message});
}

class AppStateLoading extends AppState {}

class AppStateInitial extends AppState {}



// sealed class ManagePatientsState {}
