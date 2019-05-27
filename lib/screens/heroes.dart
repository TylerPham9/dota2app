import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';
import 'package:dota2app/app.dart';

class Heroes extends StatelessWidget {
  final HeroList heroList;

  Heroes(this.heroList);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Strength"),
                Tab(text: "Agility"),
                Tab(text: "Intelligence"),
              ],
            ),
          ),
          body: TabBarView(
              children: [
                _buildBody(context, heroList.heroes['str']),
                _buildBody(context, heroList.heroes['agi']),
                _buildBody(context, heroList.heroes['int']),
              ])),
    );
  }
//
//  @override
//  Widget build(BuildContext context){
//    return DefaultTabController(
//      length: 3,
//      child: Scaffold(
//        appBar: ,
//      ),
//    )
//  }

  Widget _buildBody(BuildContext context, heroes) {
    if (heroList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: buildHeroGridView(context, heroes)),
      );
    }
  }

//  GridView buildHeroGridView(BuildContext context, Map<String, List<DotaHero>> heroes){
  GridView buildHeroGridView(BuildContext context, List<DotaHero> heroes) {
    return GridView.count(
      childAspectRatio: 11 / 8.0,
      crossAxisCount: 3,
      children: []..addAll(heroes.map((hero) => _cardGenerator(context, hero))),
    );
  }

  _cardGenerator(BuildContext context, DotaHero hero) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
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
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(hero.img),
                              fit: BoxFit.fitWidth)),
                    ),
                    Text(
                      hero.localizedName,
                      textAlign: TextAlign.center,
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
