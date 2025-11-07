abstract interface class LoginDatasource {
  Future<void> login({required String email, required String password});
}
