import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TabBarGenreState extends Equatable {
  const TabBarGenreState();

  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends TabBarGenreState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});

  @override
  List<Object> get props => [];
}

class TabLoading extends TabBarGenreState {}

class AllGenreLoaded extends TabBarGenreState {
  final bool reachMax;

  AllGenreLoaded({@required this.reachMax});

  @override
  List<Object> get props => [reachMax];

  @override
  String toString() => "All Genre tab loaded";
}

class PerempuanGenreLoaded extends TabBarGenreState {
  final bool reachMax;
  final bool busy;

  PerempuanGenreLoaded({@required this.busy, @required this.reachMax});

  @override
  List<Object> get props => [reachMax];

  @override
  String toString() => "Perempuan Genre tab loaded";
}

class Error extends TabBarGenreState {
  final String text;

  Error({@required this.text});

  @override
  List<Object> get props => [text];

  @override
  String toString() => "$text";
}

class EmptyGenre extends TabBarGenreState {
  final String text;

  EmptyGenre({@required this.text});

  @override
  String toString() => "$text";

  @override
  List<Object> get props => [text];
}

class ExpiredGenre extends TabBarGenreState {}

class RequestTimeout extends TabBarGenreState {}

class ConnectionError extends TabBarGenreState {}
