import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String message;

  const SignUpSuccess({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'SignUpSuccess { message: $message }';
}

class SignUpFinish extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RegisterFailure { error: $error }';
  //String toString() => 'Wrong email or password';
}
