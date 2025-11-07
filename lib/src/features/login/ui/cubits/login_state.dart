enum LoginStateStatus { initial, success, error, loading }

class LoginState {
  final LoginStateStatus status;

  const LoginState({this.status = LoginStateStatus.initial});

  LoginState copyWith({
    LoginStateStatus? status,
    String? email,
    String? password,
  }) {
    return LoginState(status: status ?? this.status);
  }
}
