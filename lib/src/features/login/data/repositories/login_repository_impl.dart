import 'package:chillit_test/src/features/login/data/data_sources/login_datasource.dart';
import 'package:chillit_test/src/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource _datasource;

  const LoginRepositoryImpl({required LoginDatasource datasource})
    : _datasource = datasource;

  @override
  Future<void> login({required String email, required String password}) async {
    await _datasource.login(email: email, password: password);
    return;
  }
}
