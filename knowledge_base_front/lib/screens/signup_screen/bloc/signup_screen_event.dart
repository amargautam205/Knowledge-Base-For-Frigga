abstract class SignupEvent {}

class SignupButtonPressed extends SignupEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  SignupButtonPressed(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});
}
