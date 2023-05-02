import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends HomeState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});

  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {}

class ExpiredLoaded extends HomeState {}

class EmptyHome extends HomeState {
  final String text;

  EmptyHome({@required this.text});

  @override
  String toString() => "$text";

  @override
  List<Object> get props => [text];
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Failure { error: $message }';
}

class HomeExpired extends HomeState {
  final String message;

  HomeExpired(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Failure { error: $message }';
}

class HomeSuccess extends HomeState {
  final String message;

  HomeSuccess(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Failure { message: $message }';
}

class ExpiredHome extends HomeState {}

class RequestTimeout extends HomeState {}

class ConnectionError extends HomeState {}
