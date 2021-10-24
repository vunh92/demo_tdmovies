
import 'package:equatable/equatable.dart';

abstract class UpcomingEvent extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();

}

class UpcomingLoadDataEvent extends UpcomingEvent {}

// class UpcomingLoadDataEvent extends UpcomingEvent {
//   final int index;
//
//   HomeBottomBarEvent(this.index);
//
//   @override
//   List<Object> get props => [index];
// }