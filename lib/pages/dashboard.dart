import 'package:flutter/material.dart';
import 'package:covid_india_report/constants/constants.dart';
import 'status_page.dart';
import 'package:covid_india_report/components/status_card.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double tabWidth = (deviceWidth - 32 * 3) / 3;
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xFF6200EE),
              title: Text(
                'COVID REPORTER',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 21.0,
                ),
              ),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              actions: <Widget>[
                IconButton(
                  tooltip: 'report bug',
                  icon: Icon(
                    Icons.bug_report,
                    color: Colors.white,
                  ),
                )
              ],
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 3.1,
                isScrollable: true,
                tabs: <Widget>[
                  Container(
                    padding: kHeaderPadding,
                    width: tabWidth,
                    height: kBottomTabBarHeight,
                    alignment: Alignment.center,
                    child: Text(
                      "NEWS",
                      style: kBottomTabTextStyle,
                    ),
                  ),
                  Container(
                    padding: kHeaderPadding,
                    width: tabWidth,
                    height: kBottomTabBarHeight,
                    alignment: Alignment.center,
                    child: Text(
                      "REPORT",
                      style: kBottomTabTextStyle,
                    ),
                  ),
                  Container(
                    padding: kHeaderPadding,
                    width: tabWidth,
                    height: kBottomTabBarHeight,
                    alignment: Alignment.center,
                    child: Text(
                      "EXPLORE",
                      style: kBottomTabTextStyle,
                    ),
                  )
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            StatusPage(),
            Text('a'),
            Center(child: Text('b')),
          ],
          controller: _tabController,
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Color(0xFF6200EE),
//        child: Icon(Icons.refresh),
//      ),
    );
  }
}
