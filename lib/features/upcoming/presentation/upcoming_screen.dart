import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_tdmovies/features/upcoming/presentation/bloc/upcoming_bloc.dart';
import 'package:demo_tdmovies/features/upcoming/presentation/bloc/upcoming_event.dart';
import 'package:demo_tdmovies/features/upcoming/presentation/bloc/upcoming_state.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/presentation/upcoming_detail_screen.dart';
import 'package:demo_tdmovies/features/widgets/app_loading.dart';
import 'package:demo_tdmovies/features/discover/data/models/colors.dart';
import 'package:demo_tdmovies/features/upcoming/domain/upcoming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({Key key}) : super(key: key);

  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  UpcomingBloc _upcomingBloc;

  @override
  void initState() {
    super.initState();
    _upcomingBloc = UpcomingBloc(LoadingState(isLoading: true));
    _upcomingBloc.add(UpcomingLoadDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _upcomingBloc,
      child: Scaffold(
        backgroundColor: MyColors.background,
        body: BlocBuilder<UpcomingBloc, UpcomingState>(
          builder: (context, state) {
            if (state is EmptyState) {
              return Container();
            }else if (state is LoadingState) {
              return AppLoading();
            }else if (state is LoadedState) {
              return _buildBody();
            }else if (state is ErrorState) {
              return Container(
                child: Text('Error'),
              );
            }
            return _buildBody();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      child: BlocBuilder<UpcomingBloc, UpcomingState>(
        builder: (context, state) {
          return Container(
            child: state.upcomingList != null
                ? _buildGridViewProduct(state.upcomingList)
                : Container(),
          );
          // return _buildGridViewProduct(state.upcomingList);
        },
      ),
    );
  }

  Widget _buildGridViewProduct(List<Upcoming> upcomingList) {
    return GridView.builder(
        primary: true,
        physics: ScrollPhysics(),
        itemCount: upcomingList.length,
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 2/3
        ),
        itemBuilder: (context, index) {
          return _buildItemProduct(upcomingList[index], index);
        });
  }

  Widget _buildItemProduct(Upcoming upcoming, int index) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UpcomingDetailScreen(id: upcoming.id.toString(),),));
      },
      child: CachedNetworkImage(
        imageUrl: upcoming.posterArtUrl,
        imageBuilder: (context, url) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: url, fit: BoxFit.cover ),
            ),
            // width: 80,
            // height: 120,
          );
        },
        placeholder: (context, url) => Center(
          child: Container(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
    );
  }
}
