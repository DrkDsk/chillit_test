enum LoginStateStatus { initial, success, error, loading }

class LoginState {
  final LoginStateStatus status;
  final String error;

  const LoginState({this.status = LoginStateStatus.initial, this.error = ""});

  LoginState copyWith({LoginStateStatus? status, String? error}) {
    return LoginState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
