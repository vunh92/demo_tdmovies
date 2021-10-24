import 'package:equatable/equatable.dart';

abstract class TopListsEvent extends Equatable {

  @override
  List<Object> get props => throw UnimplementedError();
}

class TopListLoadDataEvent extends TopListsEvent {}
