
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();

}

class HomeBottomBarEvent extends HomeEvent {
  final int index;
  final int indexTab;

  HomeBottomBarEvent({this.index, this.indexTab});

  @override
  List<Object> get props => [index, indexTab];
}

class DiscoverTabEvent extends HomeEvent {
  final int index;
  final int indexTab;

  DiscoverTabEvent({this.index, this.indexTab});

  @override
  List<Object> get props => [index, indexTab];
}