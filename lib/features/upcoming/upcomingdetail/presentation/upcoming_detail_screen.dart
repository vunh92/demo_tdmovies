import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/data/upcoming_detail_model.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/domain/upcoming_detail.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/presentation/bloc/upcoming_detail_event.dart';
import 'package:demo_tdmovies/features/upcoming/upcomingdetail/presentation/bloc/upcoming_detail_state.dart';
import 'package:demo_tdmovies/features/widgets/app_loading.dart';
import 'package:demo_tdmovies/features/discover/data/models/colors.dart';
import 'package:demo_tdmovies/features/discover/data/models/strings.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'bloc/upcoming_detail_bloc.dart';

class UpcomingDetailScreen extends StatefulWidget {
  final String id;
  const UpcomingDetailScreen({Key key, this.id}) : super(key: key);

  @override
  _UpcomingDetailScreenState createState() => _UpcomingDetailScreenState();
}

class _UpcomingDetailScreenState extends State<UpcomingDetailScreen> {
  UpcomingDetailBloc _upcomingDetailBloc;
  UpcomingDetail _upcomingDetail;
  
  @override
  void initState() {
    super.initState();
    _upcomingDetailBloc = UpcomingDetailBloc();
    _upcomingDetailBloc.add(UpcomingDetailLoadDataEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: BlocProvider(
        create: (context) => _upcomingDetailBloc,
        child: GestureDetector(
          // scrollDirection: Axis.vertical,
          // padding: EdgeInsets.zero,
          // physics: ClampingScrollPhysics(),
          child: BlocBuilder<UpcomingDetailBloc, UpcomingDetailState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return AppLoading();
              }
              if (state is LoadedState) {
                _upcomingDetail = state.upcomingDetail;
                return _buildBody();
              }
              if (state is ErrorState) {
                return const Text('Error');
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          _buildHeader(),
          Container(height: 1, color: MyColors.colorBottomBar,),
          _buildRating(),
          _buildDirector(),
          _buildCast(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: _upcomingDetail.posterArtUrl,
          imageBuilder: (context, url) {
            return Image(image: url, fit: BoxFit.fitWidth );
            // return Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(image: url, fit: BoxFit.fitWidth ),
            //   ),
            //   // width: double.infinity,
            //   // height: MediaQuery.of(context).size.height,
            // );
          },
          placeholder: (context, url) => Center(
            child: Container(
              width: 30,
              height: 30,
              child: const CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          height: 70,
          color: MyColors.colorBottomBar,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  print('play');
                }, icon: const Icon(Icons.play_circle_outline, size: 40, color: Colors.white,)),
                IconButton(onPressed: (){
                  print('add');
                }, icon: const Icon(Icons.add, size: 40, color: Colors.white)),
                IconButton(onPressed: (){
                  print('share');
                }, icon: const Icon(Icons.ios_share, size: 40, color: Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRating() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(MyStrings.txtRatingTitle, style: TextStyle(color: MyColors.colorText1, fontSize: 12)),
                    const Text(MyStrings.txtRateMovies, style: TextStyle(color: MyColors.colorText2, fontSize: 16),),
                    RatingBar.builder(
                      itemSize: 20,
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      unratedColor: MyColors.colorUnratedStarPrimary,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: MyColors.colorRatedStarPrimary,
                      ),
                      // onRatingUpdate: (rating) {
                      //   print(rating);
                      // },
                    ),
                  ],
                ),
                _upcomingDetail.voteAverage > 0 ? Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(MyStrings.txtTodoMoviesTitle, style: TextStyle(color: MyColors.colorText1, fontSize: 12)),
                      _upcomingDetail.voteAverage >= 8.0 ? const Text('EXCELLENT', style: TextStyle(color: MyColors.colorText2, fontSize: 16),)
                          : _upcomingDetail.voteAverage >= 5.0 ? const Text('VERY GOOD', style: TextStyle(color: MyColors.colorText2, fontSize: 16),)
                          : const Text('GOOD', style: TextStyle(color: MyColors.colorText2, fontSize: 16),),
                      RatingBar.builder(
                        itemSize: 16,
                        initialRating: _upcomingDetail.voteAverage/2,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        unratedColor: MyColors.colorUnratedStarPrimary,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: MyColors.colorRatedStarPrimary,
                        ),
                        // onRatingUpdate: (rating) {
                        //   print(rating);
                        // },
                      ),
                    ],
                  ),
                ) : Container(),
                _upcomingDetail.voteAverage > 0 ? Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(MyStrings.txtTodoMoviesTitle, style: TextStyle(color: MyColors.colorText1, fontSize: 12)),
                      Text(_upcomingDetail.voteAverage.toStringAsFixed(1).toString() + '/10', style: TextStyle(color: MyColors.colorText2, fontSize: 16),),
                    ],
                  ),
                ) : Container(),
              ],
            ),
          ),
          Container(height: 1, color: MyColors.colorBottomBar,),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
            child: Container(
              height: 80,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _upcomingDetail.productionCompanies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: CachedNetworkImage(
                      imageUrl: _upcomingDetail.productionCompanies[index].logoPath,
                      imageBuilder: (context, url) {
                        // return Image(image: url, fit: BoxFit.scaleDown );
                        return Container(
                          // decoration: BoxDecoration(
                          //   color: MyColors.colorTabBar,
                          //   image: DecorationImage(image: url, fit: BoxFit.fitHeight ),
                          // ),
                          // height: 80,
                          width: 100,
                          child: Image(image: url, fit: BoxFit.scaleDown ),
                          color: MyColors.colorBottomBar,
                        );
                      },
                      placeholder: (context, url) => Center(
                        child: Container(
                          width: 30,
                          height: 30,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(width: 0,),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: ExpandableText(
              _upcomingDetail.overview,
              expandText: 'more',
              maxLines: 4,
              linkColor: MyColors.colorPrimary,
              style: const TextStyle(color: MyColors.colorText2, fontSize: 13),
            ),
          ),
          Container(height: 1, color: MyColors.colorBottomBar,),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Custom Lists', style: TextStyle(color: MyColors.colorText1, fontSize: 13),),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Text('None', style: TextStyle(color: MyColors.colorText2, fontSize: 13),),
                    ),
                    Icon(Icons.arrow_forward_ios, color: MyColors.colorText3, size: 10,)
                  ],
                ),
              ],
            ),
          ),
          Container(height: 1, color: MyColors.colorBottomBar,),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(MyStrings.txtReleaseDate, style: TextStyle(color: MyColors.colorText1, fontSize: 12),),
                Text(_upcomingDetail.releaseDate.toString(), style: const TextStyle(color: MyColors.colorText2, fontSize: 12),),
              ],
            ),
          ),
          Container(height: 1, color: MyColors.colorBottomBar,),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(MyStrings.txtRuntime, style: TextStyle(color: MyColors.colorText1, fontSize: 12),),
                Text(_upcomingDetail.runtime.toString() + ' min', style: const TextStyle(color: MyColors.colorText2, fontSize: 12),),
              ],
            ),
          ),
          Container(height: 1, color: MyColors.colorBottomBar,),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(MyStrings.txtRating, style: TextStyle(color: MyColors.colorText1, fontSize: 12),),
                Text('NR', style: TextStyle(color: MyColors.colorText2, fontSize: 12),),
              ],
            ),
          ),
          Container(height: 1, color: MyColors.colorBottomBar,),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(MyStrings.txtGenre, style: TextStyle(color: MyColors.colorText1, fontSize: 12),),
                Text(UpcomingDetailModel.mergeGenres(_upcomingDetail.genres), style: const TextStyle(color: MyColors.colorText2, fontSize: 12),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirector() {
    return Container(
      //todo: ListView =>
    );
  }

  Widget _buildCast() {
    return Column(
      children: <Widget>[
        //todo: ListView =>
        Text('Avaliable'),
      ],
    );
  }
}
