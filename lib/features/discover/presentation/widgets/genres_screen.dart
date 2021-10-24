import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_tdmovies/features/discover/data/datasources/genres_api.dart';
import 'package:demo_tdmovies/features/discover/data/models/colors.dart';
import 'package:demo_tdmovies/features/discover/data/models/genres_model.dart';
import 'package:demo_tdmovies/features/discover/data/models/icons.dart';
import 'package:demo_tdmovies/features/discover/domain/entities/genres.dart';
import 'package:demo_tdmovies/features/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({Key key}) : super(key: key);

  @override
  _GenresScreenState createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {

  //Todo: createBloc
  Future<List<Genres>> genresList;
  final genresApi = GenresApi();


  @override
  void initState() {
    super.initState();
    genresList = getGenresList();
  }

  Future<List<Genres>> getGenresList() async {
    final response = await genresApi.getGenresListSubCategory().timeout(Duration(seconds: 30), onTimeout: () {
      return null;
    });
    if (response.statusCode == 200) {
      return parseGenres(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
  List<Genres> parseGenres(String responseBody) {
    // return (jsonDecode(responseBody)['results'] as List<dynamic>).map<Genres>((product) => GenresModel.fromJson(product)).toList();
    final parsed = jsonDecode(responseBody)['results'].cast<Map<String, dynamic>>() as List<dynamic>;
    return parsed.map<Genres>((json) => GenresModel.fromJson(json)).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // _buildAppBar(),
          // _buildBlockAllVendor(),
          // _buildTitleCategory('Nông dược'),

          /// block list Sub Category
          /*Container(
            child: state.listSubCategory != null
                ? _buildListSubCategory(state.listSubCategory)
                : Container(),
          ),*/
          Expanded(
            child: FutureBuilder<List<Genres>>(
              future: genresList,
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData ? Container(
                  /*child: geresList != null
                      ? _buildGenresList(snapshot.data)
                      : Container(),*/
                  child: _buildGenresList(snapshot.data),
                  )
                  :Center(child: CircularProgressIndicator()) ;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenresList(List<Genres> genresList) {
    return Container(
      color: Colors.white,
      height: 130,
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(left: 5, right: 5),
      child: ListView.builder(
          itemCount: genresList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return _buildItemSubCategory2(genresList[index]);
          }),
    );
  }

  /*Widget _buildItemSubCategory(Genres genres) {
    return Container(
      // width: 90,
      // padding: EdgeInsets.all(5),
      padding: const EdgeInsets.only(top: 3),
      child: RawMaterialButton(
        onPressed: () {
          print(genres.id);
        },
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: <Widget>[
            NetWorkImage(
              // width: 80,
              height: 120,
              url: genres.backdropArtUrl,
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
                      genres.title,
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
                            genres.voteCount.toString(),
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
  }*/

  Widget _buildItemSubCategory2(Genres genres) {
    return Container(
      // padding: const EdgeInsets.only(top: 3),
      // child: RawMaterialButton(
      //   onPressed: () {
      //     print(genres.title);
      //   },
      //   child: CachedNetworkImage(
      //     imageUrl: genres.backdropArtUrl,
      //     imageBuilder: (context, url) {
      //       return Stack(
      //         children: <Widget>[
      //           Container(
      //             height: 120,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.all(
      //                   Radius.circular(10),
      //                 ),
      //               image: DecorationImage(image: url, fit: BoxFit.cover ),
      //             ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(left: 8.0),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 Container(
      //                   margin: EdgeInsets.only(top: 5),
      //                   child: Text(
      //                     genres.title,
      //                     style: TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 22,
      //                         fontWeight: FontWeight.bold
      //                     ),
      //                   ),
      //                 ),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   children: <Widget>[
      //                     Image.asset(MyIcons.icLove, width: 20, height: 20, fit: BoxFit.cover),
      //                     Padding(
      //                       padding: const EdgeInsets.only(left: 8.0),
      //                       child: Container(
      //                         child: Text(
      //                           genres.voteCount.toString(),
      //                           style: TextStyle(
      //                               color: MyColors.background,
      //                               fontSize: 14,
      //                               fontWeight: FontWeight.bold
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.only(left: 8.0),
      //                       child: Container(
      //                         child: Text(
      //                           'Likes',
      //                           style: TextStyle(
      //                               color: MyColors.background,
      //                               fontSize: 14,
      //                               fontWeight: FontWeight.bold
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 )
      //               ],
      //             ),
      //           )
      //         ]
      //       );
      //     },
      //     placeholder: (context, url) => Center(
      //       child: Container(
      //         width: 30,
      //         height: 30,
      //         child: CircularProgressIndicator(),
      //       ),
      //     ),
      //     errorWidget: (context, url, error) => new Icon(Icons.error),
      //   )
      // ),
    );
  }
}
