import 'dart:convert';

import 'package:demo_tdmovies/features/upcoming/upcomingdetail/data/upcoming_detail_api.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/data/upcoming_detail_model.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/domain/upcoming_detail.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/presentation/bloc/upcoming_detail_event.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/presentation/bloc/upcoming_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingDetailBloc extends Bloc<UpcomingDetailEvent, UpcomingDetailState> {
  final upcomingApi = UpcomingDetailApi();

  UpcomingDetailBloc({UpcomingDetailState initialState});

  @override
  UpcomingDetailState get initialState => LoadingState();

  @override
  Stream<UpcomingDetailState> mapEventToState(UpcomingDetailEvent event) async* {
    if (event is UpcomingDetailLoadDataEvent) {
      yield await _mapEventToGetUpcomingDetail(event, state);
    }
  }

  Future<UpcomingDetailState> _mapEventToGetUpcomingDetail(UpcomingDetailLoadDataEvent event, UpcomingDetailState state) async {
    try {
      /// call api get list Product
      final responseUpcomingDetailList = await upcomingApi
          .getUpcomingDetailApi(event.id)
          .timeout(Duration(seconds: 30), onTimeout: () {
        // GeneralDialog.showDialogNotify(context, 'Time out!');
        return null;
      });
      UpcomingDetail upcomingDetail;
      if (responseUpcomingDetailList.statusCode == 200) {
        upcomingDetail = UpcomingDetailModel.fromJson(json.decode(responseUpcomingDetailList.body));
      } else {
        throw responseUpcomingDetailList.reasonPhrase;
      }
      return upcomingDetail != null ? LoadedState(upcomingDetail: upcomingDetail) : ErrorState();

    } catch (e) {
      print("Error: $e");
      return ErrorState();
    }
  }
}