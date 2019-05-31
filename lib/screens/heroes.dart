import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';
import 'package:dota2app/app.dart';

class Heroes extends StatelessWidget {
  final HeroList heroList;

  Heroes(this.heroList);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    if (heroList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
//      return _HeroTabController(context, heroList);
      return TabBarApp(heroList);
    }
  }

//  DefaultTabController _HeroTabController(
//      BuildContext context, HeroList heroList) {
//    return DefaultTabController(
//      length: 3,
//      child: Scaffold(
//        appBar: AppBar(
//          title: Text("Dota 2 Heroes"),
////            backgroundColor: Colors.orange,
//          bottom: TabBar(
//            tabs: [
//              Tab(text: "Strength"),
//              Tab(text: "Agility"),
//              Tab(text: "Intelligence"),
//            ],
//          ),
//        ),
//        body: TabBarView(children: [
//          Container(
//            child: Padding(
//                padding: EdgeInsets.symmetric(horizontal: 16.0),
//                child: _buildHeroGridView(context, heroList.heroes['str'])),
//          ),
//          Container(
//            child: Padding(
//                padding: EdgeInsets.symmetric(horizontal: 16.0),
//                child: _buildHeroGridView(context, heroList.heroes['agi'])),
//          ),
//          Container(
//            child: Padding(
//                padding: EdgeInsets.symmetric(horizontal: 16.0),
//                child: _buildHeroGridView(context, heroList.heroes['int'])),
//          ),
//        ]),
//      ),
//    );
//  }

//  GridView buildHeroGridView(BuildContext context, Map<String, List<DotaHero>> heroes){
  Widget _buildHeroGridView(BuildContext context, List<DotaHero> heroes) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
            itemCount: heroes.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return _cardGenerator(context, heroes[index]);
            }),
      ),
    );
  }

  _cardGenerator(BuildContext context, DotaHero hero) {
    return Padding(
        padding: EdgeInsets.all(4.0),
        child: InkWell(
            onTap: () {
              print(hero.localizedName + ' tapped');
            },
            child: Card(
              borderOnForeground: true,
              margin: const EdgeInsets.all(0),
              child: GestureDetector(
                onTap: () => _onHeroTap(context, hero),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 75.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(hero.img),
                              fit: BoxFit.fitWidth)),
                    ),
                    Text(
                      hero.localizedName,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                  ],
                ),
              ),
            )));
  }

  _onHeroTap(BuildContext context, DotaHero hero) {
//  _onHeroTap(BuildContext context, int heroID) {
    Navigator.pushNamed(context, HeroDetailRoute, arguments: {"hero": hero});
//    Navigator.pushNamed(context, HeroDetailRoute, arguments: {"id": heroID});
  }
}

class TabBarApp extends StatefulWidget {
  final HeroList heroList;

  TabBarApp(this.heroList);
  createState() => _TabBarAppState(heroList);
}

class _TabBarAppState extends State<TabBarApp>
    with SingleTickerProviderStateMixin {
  HeroList _heroList;

  TabController _controller;
  List<HeroTabData> _tabData;
  List<Tab> _tabs = [];
  List<Widget> _tabViews = [];
  Color _activeColor;

  _TabBarAppState(this._heroList);

  @override
  void initState() {
    super.initState();
    _tabData = [
      HeroTabData(
          title: 'Strength',
          color: Colors.red,
          heroes: _heroList.heroes['str']),
      HeroTabData(
          title: 'Agility',
          color: Colors.green,
          heroes: _heroList.heroes['agi']),
      HeroTabData(
          title: 'Intelligence',
          color: Colors.blue,
          heroes: _heroList.heroes['int']),
    ];
    _activeColor = _tabData.first.color;
    _tabData.forEach((data) {
      final tab = Tab(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: data.color,
          child: Center(
            child: Text(data.title),
          ),
        ),
      );
      _tabs.add(tab);

      _tabViews.add(_buildHeroGridView(context, data.heroes));
    });
    _controller = TabController(vsync: this, length: _tabData.length)
      ..addListener(() {
        setState(() {
          _activeColor = _tabData[_controller.index].color;
        });
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: _activeColor),
      child: Scaffold(
        backgroundColor: _activeColor,
        appBar: AppBar(
          title: Text("Dota 2 Heroes"),
          bottom: TabBar(
            indicatorColor: _activeColor,
            labelPadding: EdgeInsets.zero,
            controller: _controller,
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: _tabViews,
        ),
      ),
    );
  }

  Widget _buildHeroGridView(BuildContext context, List<DotaHero> heroes) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
            itemCount: heroes.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return _cardGenerator(context, heroes[index]);
            }),
      ),
    );
  }

  _cardGenerator(BuildContext context, DotaHero hero) {
    return Padding(
        padding: EdgeInsets.all(4.0),
        child: InkWell(
            onTap: () {
              print(hero.localizedName + ' tapped');
            },
            child: Card(
              borderOnForeground: true,
              margin: const EdgeInsets.all(0),
              child: GestureDetector(
                onTap: () => _onHeroTap(context, hero),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 75.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(hero.img),
                              fit: BoxFit.fitWidth)),
                    ),
                    Text(
                      hero.localizedName,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                  ],
                ),
              ),
            )));
  }

  _onHeroTap(BuildContext context, DotaHero hero) {
//  _onHeroTap(BuildContext context, int heroID) {
    Navigator.pushNamed(context, HeroDetailRoute, arguments: {"hero": hero});
//    Navigator.pushNamed(context, HeroDetailRoute, arguments: {"id": heroID});
  }
}

class HeroTabData {
  HeroTabData({this.title, this.color, this.heroes});

  final String title;
  final Color color;
  final List<DotaHero> heroes;
}
