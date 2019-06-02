import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';
import 'package:dota2app/models/HeroTabData.dart';

import 'package:dota2app/app.dart';
import 'package:dota2app/style.dart';

class HeroesTabs extends StatefulWidget {
  final HeroList heroList;

  HeroesTabs(this.heroList);
  createState() => _HeroesTabsState(heroList);
}

class _HeroesTabsState extends State<HeroesTabs>
    with SingleTickerProviderStateMixin {
  HeroList _heroList;

  TabController _controller;
  List<HeroTabData> _tabData;
  List<Tab> _tabs = [];
  List<Widget> _tabViews = [];
  Color _activeColor;

  _HeroesTabsState(this._heroList);

  @override
  void initState() {
    super.initState();
    _tabData = [
      HeroTabData(
          title: 'Strength',
          color: attrColors['str'],
          heroes: _heroList.heroes['str']),
      HeroTabData(
          title: 'Agility',
          color: attrColors['agi'],
          heroes: _heroList.heroes['agi']),
      HeroTabData(
          title: 'Intelligence',
          color: attrColors['int'],
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
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                childAspectRatio: 1.2),
            itemBuilder: (BuildContext context, int index) {
              return _cardGenerator(context, heroes[index]);
            }),
      ),
    );
  }

  Widget _cardGenerator(BuildContext context, DotaHero hero) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(hero.img), fit: BoxFit.fitWidth)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      hero.localizedName,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onHeroTap(BuildContext context, DotaHero hero) {
//  _onHeroTap(BuildContext context, int heroID) {
    Navigator.pushNamed(context, HeroDetailRoute, arguments: {"hero": hero});
//    Navigator.pushNamed(context, HeroDetailRoute, arguments: {"id": heroID});
  }
}
