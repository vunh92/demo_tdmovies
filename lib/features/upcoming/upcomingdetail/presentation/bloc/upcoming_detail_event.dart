
import 'package:equatable/equatable.dart';

abstract class UpcomingDetailEvent extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();

}

class UpcomingDetailLoadDataEvent extends UpcomingDetailEvent {
  String id;

  UpcomingDetailLoadDataEvent({this.id});

  @override
  List<Object> get props => [id];

}