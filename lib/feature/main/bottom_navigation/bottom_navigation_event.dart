import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BottomNavigationEvent extends Equatable {
  BottomNavigationEvent() : super();
}

class PageStarted extends BottomNavigationEvent {
  @override
  String toString() => '';

  @override
  List<Object> get props => [];
}

class PageTapped extends BottomNavigationEvent {
  final int index;

  PageTapped({@required this.index}) : super();

  @override
  String toString() => 'PageTapped: $index';

  @override
  List<Object> get props => [];
}

class   BackButtonTapped extends BottomNavigationEvent {
  final int index;

  BackButtonTapped({@required this.index}) : super();
  @override
  List<Object> get props => [];
}
