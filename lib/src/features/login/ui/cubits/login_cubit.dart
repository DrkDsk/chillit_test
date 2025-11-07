import 'package:bloc/bloc.dart';
import 'package:chillit_test/src/features/login/domain/repositories/login_repository.dart';
import 'package:chillit_test/src/features/login/ui/cubits/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginCubit({required LoginRepository repository})
    : _loginRepository = repository,
      super(LoginState());

  Future<void> login({required String email, required String password}) async {
    try {
      await _loginRepository.login(email: email, password: password);
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: LoginStateStatus.error));
    }
  }
}
