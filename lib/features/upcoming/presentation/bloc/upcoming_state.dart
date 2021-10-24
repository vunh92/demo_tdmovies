import 'package:demo_tdmovies/features/upcoming/domain/upcoming.dart';
import 'package:equatable/equatable.dart';

abstract class UpcomingState extends Equatable {
  final bool isLoading;
  final List<Upcoming> upcomingList;

  UpcomingState({this.isLoading, this.upcomingList});

  @override
  List<Object> get props => [isLoading, upcomingList];

}

class EmptyState extends UpcomingState {}

class LoadingState extends UpcomingState {
  LoadingState({bool isLoading, List<Upcoming> upcomingList}) : super(isLoading: isLoading, upcomingList: upcomingList);
}

class LoadedState extends UpcomingState {
  LoadedState({bool isLoading, List<Upcoming> upcomingList}) : super(isLoading: isLoading, upcomingList: upcomingList);
}

class ErrorState extends UpcomingState {}