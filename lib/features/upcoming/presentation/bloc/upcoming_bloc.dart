import 'dart:convert';

import 'package:demo_tdmovies/features/upcoming/data/upcoming_api.dart';
import 'package:demo_tdmovies/features/upcoming/data/upcoming_model.dart';
import 'package:demo_tdmovies/features/upcoming/domain/upcoming.dart';
import 'package:demo_tdmovies/features/upcoming/presentation/bloc/upcoming_event.dart';
import 'package:demo_tdmovies/features/upcoming/presentation/bloc/upcoming_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {
  final upcomingApi = UpcomingApi();

  UpcomingBloc(UpcomingState initialState) : super();

  @override
  UpcomingState get initialState => LoadingState(isLoading: true);

  @override
  Stream<UpcomingState> mapEventToState(UpcomingEvent event) async* {
    if (event is UpcomingLoadDataEvent) {
      yield await _mapEventToGetUpcomingList(event, state);
    }
  }

  Future<UpcomingState> _mapEventToGetUpcomingList(UpcomingEvent event, UpcomingState state) async {
    try {
      /*final response = upcomingApi
          .getUpcomingList()
          .timeout(Duration(seconds: 30), onTimeout: () {
        // GeneralDialog.showDialogNotify(context, 'Time out!');
        return null;
      });*/

      List<Upcoming> upcomingList = await getUpcomingList();

      return LoadedState(isLoading: false, upcomingList: upcomingList);

      /*await response.then((responseRaw) async {
        if (responseRaw.statusCode == 200) {
          upcomingList = (json.decode(responseRaw.body)['results'] as List)
              .map((e) => UpcomingModel.fromJson(e))
              .toList();

          /// call api get list connect vendor.
          listProduct = await getListProduct();

          print(listSubCategory.map((e) => e.toJson()).toList());
        } else {
          throw (responseRaw.reasonPhrase);
        }
      });*/

    } catch (e) {
      print("Error $e");
      return LoadingState(isLoading: false);
    }
  }

  Future<List<Upcoming>> getUpcomingList() async {
    try {
      /// call api get list Product
      final responseUpcomingList = await upcomingApi
          .getUpcomingList()
          .timeout(Duration(seconds: 30), onTimeout: () {
        // GeneralDialog.showDialogNotify(context, 'Time out!');
        return null;
      });

      List<Upcoming> _listProduct;
      if (responseUpcomingList.statusCode == 200) {
        _listProduct = ((json.decode(responseUpcomingList.body)['results'] as List)
            .map((json) => UpcomingModel.fromJson(json)))
            .toList();
        return _listProduct;
      } else {
        throw responseUpcomingList.reasonPhrase;
      }
    } catch (e) {
      print(e);
      // GeneralDialog.showDialogNotify(context, e);
      LoadingState(isLoading: false);
      return null;
    }
  }
}