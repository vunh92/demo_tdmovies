import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  final int index;
  final int indexTab;

  HomeState({this.index, this.indexTab,});

  @override
  List<Object> get props => [index, indexTab];

}

class EmptyState extends HomeState {
  EmptyState({int index, int indexTab}) : super(index: index, indexTab: indexTab);
}

class LoadingState extends HomeState {}

class HomeBottomBarState extends HomeState {
  HomeBottomBarState({int index, int indexTab}) : super(index: index, indexTab: indexTab);
}

class DiscoverTabState extends HomeState {
  DiscoverTabState({int index, int indexTab}) : super(index: index, indexTab: indexTab);
}