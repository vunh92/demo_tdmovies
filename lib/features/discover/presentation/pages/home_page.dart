import 'package:demo_tdmovies/features/discover/data/models/colors.dart';
import 'package:demo_tdmovies/features/discover/data/models/icons.dart';
import 'package:demo_tdmovies/features/discover/data/models/strings.dart';
import 'package:demo_tdmovies/features/discover/presentation/bloc/home_bloc.dart';
import 'package:demo_tdmovies/features/discover/presentation/bloc/home_event.dart';
import 'package:demo_tdmovies/features/discover/presentation/bloc/home_state.dart';
import 'package:demo_tdmovies/features/discover/presentation/pages/discover_page.dart';
import 'package:demo_tdmovies/features/discover/presentation/pages/my_list_page.dart';
import 'package:demo_tdmovies/features/discover/presentation/pages/news_page.dart';
import 'package:demo_tdmovies/features/discover/presentation/pages/search_page.dart';
import 'package:demo_tdmovies/features/discover/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List lisScreen = [];
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
    lisScreen = [
      DiscoverPage(homeBloc: _homeBloc,),
      MyListPage(),
      SearchPage(),
      NewsPage(),
      SettingsPage()
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _homeBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeBloc,
      child: Scaffold(
        backgroundColor: MyColors.background,
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                int _index = 0;
                if (state is EmptyState) {
                  _index = 0;
                }
                if (state is HomeBottomBarState) {
                  _index = state != null ? state.index : 0;
                }
                return lisScreen[_index];
              }),
        ),
        bottomNavigationBar: SizedBox(
          // height: 50,
          child: _buildBottomBar(),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          int _index;
          if (state is EmptyState) {_index = 0;}
          if (state is HomeBottomBarState) {
            _index = state != null ? state.index : 0;
          }
          if (state is DiscoverTabState) {
            _index = state != null ? state.index : 0;
          }
          return BottomNavigationBar(
            backgroundColor: MyColors.colorBottomBar,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            currentIndex: _index,
            onTap: (index) {
              /// push index bottom navigation bar
              context.bloc<HomeBloc>().add(HomeBottomBarEvent(index: index, indexTab: state.indexTab ?? 0));
            },
            items: [
              _buildBottomBarItem2(const Icon(Icons.star), const Icon(Icons.star, color: Colors.teal,), MyStrings.txtDiscover),
              _buildBottomBarItem2(const Icon(Icons.format_list_bulleted_sharp,), const Icon(Icons.format_list_bulleted_sharp, color: Colors.lightBlue,), MyStrings.txtMyList),
              _buildBottomBarItem2(const Icon(Icons.search,), const Icon(Icons.search, color: Colors.orange,), MyStrings.txtSearch),
              _buildBottomBarItem2(const Icon(Icons.list_alt_sharp,), const Icon(Icons.list_alt_sharp, color: Colors.cyan,), MyStrings.txtNews),
              _buildBottomBarItem2(const Icon(Icons.settings,), const Icon(Icons.settings, color: Colors.amberAccent,), MyStrings.txtSettings),
              // _buildBottomBarItem(MyIcons.icBotHomePage, MyIcons.icBotHomePageFocus, MyStrings.txtHome),
              // _buildBottomBarItem(MyIcons.icBotShop, MyIcons.icBotShopFocus, MyStrings.txtShop),
              // _buildBottomBarItem(MyIcons.icBotMessenger, MyIcons.icBotMessengerFocus, MyStrings.txtMessenger),
              // _buildBottomBarItem(MyIcons.icBotMyOrder, MyIcons.icBotMyOrderFocus, MyStrings.txtMyOrder),
              // _buildBottomBarItem(MyIcons.icBotAccount, MyIcons.icBotAccountFocus, MyStrings.txtAccount),
            ],
          );
        });
  }

  BottomNavigationBarItem _buildBottomBarItem(
      String icon, String iconFocus, String title) {
    return BottomNavigationBarItem(
      icon: Image.asset(icon, width: 24, height: 24, fit: BoxFit.cover,),
      activeIcon: Image.asset(iconFocus, width: 24, height: 24, fit: BoxFit.cover,),
      title: Text(title, style: TextStyle(fontSize: 11),),
    );
  }

  BottomNavigationBarItem _buildBottomBarItem2(
      Icon icon, Icon iconFocus, String title) {
    return BottomNavigationBarItem(
      icon: icon,
      // activeIcon: iconFocus,
      title: Text(title, style: TextStyle(fontSize: 9),),
    );
  }
}
