import 'package:demo_tdmovies/features/upcoming/upcomingdetail/domain/upcoming_detail.dart';
import 'package:equatable/equatable.dart';

abstract class UpcomingDetailState extends Equatable {
  final UpcomingDetail upcomingDetail;

  UpcomingDetailState({this.upcomingDetail});

  @override
  List<Object> get props => [upcomingDetail];

}

class EmptyState extends UpcomingDetailState {}

class LoadingState extends UpcomingDetailState {}

class LoadedState extends UpcomingDetailState {
  LoadedState({UpcomingDetail upcomingDetail}) : super(upcomingDetail: upcomingDetail);
}

class ErrorState extends UpcomingDetailState {}