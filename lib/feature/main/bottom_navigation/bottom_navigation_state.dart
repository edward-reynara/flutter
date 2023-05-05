import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BottomNavigationState extends Equatable {
  BottomNavigationState([List props = const []]) : super();
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex}) : super([currentIndex]);

  @override
  List<Object> get props => [];
}

class PageLoading extends BottomNavigationState {
  @override
  List<Object> get props => [];
}

class HomePageLoaded extends BottomNavigationState {
  final String text;
  final bool reachMax;
  final String status;

  HomePageLoaded(
      {@required this.text, @required this.reachMax, @required this.status})
      : super([text]);

  @override
  List<Object> get props => [text, reachMax, status];

  @override
  String toString() => "home page load with text: $text";
}

class CategoriesPageLoaded extends BottomNavigationState {
  final String text;

  CategoriesPageLoaded({@required this.text}) : super([text]);

  @override
  List<Object> get props => [];

  @override
  String toString() => "categories page load with text: $text";
}

class AddPageLoaded extends BottomNavigationState {
  final String text;

  AddPageLoaded({@required this.text}) : super([text]);

  @override
  List<Object> get props => [];

  @override
  String toString() => "add page load with text: $text";
}

class GenrePageLoaded extends BottomNavigationState {
  final String text;

  GenrePageLoaded({@required this.text}) : super([text]);

  @override
  List<Object> get props => [];

  @override
  String toString() => "search page load with text: $text";
}

class SettingsPageLoaded extends BottomNavigationState {
  final String text;

  SettingsPageLoaded({@required this.text}) : super([text]);

  @override
  List<Object> get props => [];

  @override
  String toString() => "settings page load with text: $text";
}

class ExitPageLoaded extends BottomNavigationState {
  @override
  List<Object> get props => [];
}
