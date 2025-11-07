import 'package:chillit_test/src/features/login/data/data_sources/login_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginDatasourceImpl implements LoginDatasource {
  @override
  Future<void> login({required String email, required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
