import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpStarted extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String password;
  final String name;
  final String confirm_password;

  SignUpButtonPressed(
      {@required this.email,
      @required this.password,
      @required this.confirm_password,
      @required this.name});

  @override
  List<Object> get props => [email, password, confirm_password, name];

  @override
  String toString() =>
      'SignUpButtonPressed { email: $email, password: $password, confirm_password: $confirm_password, name: $name }';
}

class Registered extends SignUpEvent {
  const Registered();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Registered';
}
