import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TabBarGenreEvent extends Equatable {
  const TabBarGenreEvent();
}

class TabStarted extends TabBarGenreEvent {
  @override
  List<Object> get props => [];
}

class TabTapped extends TabBarGenreEvent {
  final int index;

  TabTapped({@required this.index}) : super();

  @override
  String toString() => 'TabTapped: $index';

  @override
  List<Object> get props => [];
}

class TabSearch extends TabBarGenreEvent {
  @override
  List<Object> get props => [];
}

class NewItems extends TabBarGenreEvent {
  @override
  List<Object> get props => [];
}
