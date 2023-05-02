import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String token;

  final int userId;
  final String userEmail;
  final String username;

  const LoggedIn(
      {@required this.token,
        @required this.userId,
        @required this.userEmail,
        @required this.username});

  @override
  List<Object> get props => [token, userId, userEmail];

  @override
  String toString() => 'LoggedIn { userId: $userId}';
}

class LoggedOut extends AuthenticationEvent {}

// class SaveUser extends AuthenticationEvent {
//   final int idUser;
//   final String emailUser;

//   SaveUser({@required this.idUser, @required this.emailUser});

//   @override
//   List<Object> get props => [idUser, emailUser];

//   @override
//   String toString() => 'AppPressed { idUser: $idUser}';
// }
