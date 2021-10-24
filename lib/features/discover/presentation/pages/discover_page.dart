import 'package:demo_tdmovies/features/discover/data/models/colors.dart';
import 'package:demo_tdmovies/features/discover/presentation/bloc/home_bloc.dart';
import 'package:demo_tdmovies/features/discover/presentation/bloc/home_event.dart';
import 'package:demo_tdmovies/features/discover/presentation/bloc/home_state.dart';
import 'package:demo_tdmovies/features/discover/presentation/widgets/genres_screen.dart';
import 'package:demo_tdmovies/features/toplists/presentation/toplists_screen.dart';
import 'package:demo_tdmovies/features/upcoming/presentation/upcoming_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverPage extends StatefulWidget {
  final HomeBloc homeBloc;
  const DiscoverPage({Key key, this.homeBloc}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin{
  TabController _tabController;
  final quantiTab = 4;
  List<Widget> _lisTabScreen;
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = widget.homeBloc;
    _lisTabScreen = [
      TopListsScreen(),
      GenresScreen(),
      Icon(Icons.movie),
      UpcomingScreen(),
    ];
    _tabController = TabController(length: quantiTab, vsync: this, initialIndex: _homeBloc.state.indexTab ?? 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _tabBar2(context);
  }


  Widget _tabBar1(BuildContext context) {
    return DefaultTabController(
      length: quantiTab,
      child: Scaffold(
        appBar: TabBar(
          // bottom: TabBar(
            labelStyle: TextStyle(fontSize: 9, color: Colors.white),
            unselectedLabelColor: Colors.redAccent,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.redAccent),
            tabs: <Widget>[
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.redAccent, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("APPS"),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.redAccent, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("MOVIES"),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.redAccent, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("GAMES"),
                  ),
                ),
              ),
            ]),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
            children: _lisTabScreen
        ),
      ),
    );
  }

  Widget _tabBar2(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => DefaultTabController(
        length: quantiTab,
        child: Scaffold(
          backgroundColor: MyColors.background,
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: MyColors.colorBottomBar,
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) => TabBar(
                      controller: _tabController,
                      labelStyle: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        color: Colors.redAccent,
                      ),
                      // labelColor: Colors.white,
                      // unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(
                          text: 'Top Lists',
                        ),
                        Tab(
                          text: 'Genres',
                        ),
                        Tab(
                          text: 'In Theaters',
                        ),
                        Tab(
                          text: 'Upcoming',
                        ),
                      ],
                      onTap: (value) {
                        _homeBloc.add(DiscoverTabEvent(index: state.index ?? 0, indexTab: value));
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: _lisTabScreen
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabBar3(BuildContext context) {
    return DefaultTabController(
      length: quantiTab,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 1,
          title: TabBar(
              unselectedLabelColor: Colors.redAccent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.orangeAccent]),
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.redAccent),
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("APPS"),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("MOVIES"),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("GAMES"),
                  ),
                ),
              ]),
          ),
        body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: _lisTabScreen
        ),
      ),
    );
  }

}
