import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_tdmovies/features/toplists/domain/toplists.dart';
import 'package:demo_tdmovies/features/toplists/presentation/bloc/toplists_bloc.dart';
import 'package:demo_tdmovies/features/toplists/presentation/bloc/toplists_event.dart';
import 'package:demo_tdmovies/features/toplists/presentation/bloc/toplists_state.dart';
import 'package:demo_tdmovies/features/widgets/app_loading.dart';
import 'package:demo_tdmovies/features/discover/data/models/colors.dart';
import 'package:demo_tdmovies/features/discover/data/models/icons.dart';
import 'package:demo_tdmovies/features/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopListsScreen extends StatefulWidget {
  const TopListsScreen({Key key}) : super(key: key);

  @override
  _TopListsScreenState createState() => _TopListsScreenState();
}

class _TopListsScreenState extends State<TopListsScreen> {
  TopListsBloc _topListsBloc;
  // Future<List<TopLists>> topListsList;
  // final topListsApi = TopListsApi();

  @override
  void initState() {
    super.initState();
    // topListsList = getTopListsList();
    _topListsBloc = TopListsBloc();
    _topListsBloc.add(TopListLoadDataEvent());
  }

  /*Future<List<TopLists>> getTopListsList() async {
    final response = await topListsApi.getTopListsList().timeout(Duration(seconds: 30), onTimeout: () {
      return null;
    });
    if (response.statusCode == 200) {
      return parseTopLists(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }
  List<TopLists> parseTopLists(String responseBody) {
    // return (jsonDecode(responseBody)['results'] as List<dynamic>).map<TopLists>((product) => TopListsModel.fromJson(product)).toList();
    final parsed = jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>() as List<dynamic>;
    return parsed.map<TopLists>((json) => TopListsModel.fromJson(json)).toList();
  }*/


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _topListsBloc,
      child: Scaffold(
        backgroundColor: MyColors.background,
        body: BlocBuilder<TopListsBloc, TopListsState>(
          builder: (context, state) {
            if (state is EmptyState) {
              return Container();
            }
            else if (state is LoadingState) {
              return AppLoading();
            }
            else if (state is LoadedState) {
              return _buildBody();
            }
            else if (state is ErrorState) {
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
      child: BlocBuilder<TopListsBloc, TopListsState>(
        builder: (context, state) {
          /*return state.topListsList != null
              ? _buildTopListsList(state.topListsList)
              : const Expanded(
            child: Text('error'),
          );*/
          return _buildTopListsList(state.topListsList);
        },
      ),
    );
  }

  Widget _buildTopListsList(List<TopLists> topListsList) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        primary: true,
        itemCount: topListsList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return _buildItemSubCategory2(topListsList[index]);
        }),
    );
  }

  Widget _buildItemSubCategory(TopLists topLists) {
    return Container(
      // width: 90,
      // padding: EdgeInsets.all(5),
      padding: const EdgeInsets.only(top: 3),
      child: RawMaterialButton(
        onPressed: () {
          print(topLists.title);
        },
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: <Widget>[
            NetWorkImage(
              // width: 80,
              height: 120,
              url: topLists.backdropArtUrl,
              radius: 2,
              boxFit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      topLists.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(MyIcons.icLove, width: 20, height: 20, fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          child: Text(
                            topLists.voteCount.toString(),
                            style: TextStyle(
                                color: MyColors.background,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          child: Text(
                            'Likes',
                            style: TextStyle(
                                color: MyColors.background,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemSubCategory2(TopLists topLists) {
    return Container(
      color: MyColors.background,
      height: 120,
      margin: const EdgeInsets.only(bottom: 3),
      child: RawMaterialButton(
          onPressed: () {
            print(topLists.title);
          },
          child: CachedNetworkImage(
            imageUrl: topLists.backdropArtUrl,
            imageBuilder: (context, url) {
              return Stack(
                  children: <Widget>[
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        /*borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),*/
                        image: DecorationImage(image: url, fit: BoxFit.cover ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              topLists.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(MyIcons.icLove, width: 20, height: 20, fit: BoxFit.cover),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  child: Text(
                                    topLists.voteCount.toString(),
                                    style: TextStyle(
                                        color: MyColors.colorText2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  child: Text(
                                    'Likes',
                                    style: TextStyle(
                                        color: MyColors.background,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ]
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
          )
      ),
    );
  }
}
