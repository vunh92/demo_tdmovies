import 'dart:async';
import 'package:demo_tdmovies/features/discover/presentation/bloc/home_event.dart';
import 'package:demo_tdmovies/features/discover/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc({HomeState homeState});

  @override
  HomeState get initialState => EmptyState(index: 0, indexTab: 0);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeBottomBarEvent) {
      yield _mapHomeBottomBarEvent(event , state);
    }
    if (event is DiscoverTabEvent) {
      yield _mapDiscoverTabEvent(event , state);
    }
  }

  HomeState _mapHomeBottomBarEvent(HomeBottomBarEvent event, HomeState state) {
    return HomeBottomBarState(index: event.index, indexTab: event.indexTab);
  }

  HomeState _mapDiscoverTabEvent(DiscoverTabEvent event, HomeState state) {
    return DiscoverTabState(index: event.index, indexTab: event.indexTab);
  }
}