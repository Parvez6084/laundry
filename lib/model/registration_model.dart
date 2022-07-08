class RegistrationModel {
  String? email;
  String? password;
  String? rePassword;

  RegistrationModel(
      {
      this.email,
      this.password,
      this.rePassword});

  @override
  String toString() {
    return 'RegistrationModel{firstName: email: $email, password: $password, rePassword: $rePassword}';
  }
}
