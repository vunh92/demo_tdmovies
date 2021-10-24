import 'package:demo_tdmovies/features/toplists/domain/toplists.dart';
import 'package:equatable/equatable.dart';

abstract class TopListsState extends Equatable {
  final List<TopLists> topListsList;

  TopListsState({this.topListsList});

  @override
  List<Object> get props => [topListsList];
}

class EmptyState extends TopListsState {}

class LoadingState extends TopListsState {
  LoadingState({List<TopLists> topListsList}) : super(topListsList: topListsList);
}

class LoadedState extends TopListsState {
  LoadedState({List<TopLists> topListsList}) : super(topListsList: topListsList);
}

class ErrorState extends TopListsState {}