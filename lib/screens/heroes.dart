import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';
import 'package:dota2app/app.dart';

const ImageHost = 'http://cdn.dota2.com';

class Heroes extends StatelessWidget {
  final HeroHub heroHub;

  Heroes(this.heroHub);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dota 2 Heroes'),
          backgroundColor: Colors.red,
        ),
        body: heroHub == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.count(
                childAspectRatio: 10 / 9.0,
                crossAxisCount: 4,
                children: heroHub.heroes
                    .map((hero) => Padding(
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
                                            image: NetworkImage(
                                                ImageHost + hero.img),
                                            fit: BoxFit.fitWidth)),
                                  ),
                                  Text(
                                    hero.localizedName,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )))
                    .toList(),
              ));
  }

  _onHeroTap(BuildContext context, DotaHero hero) {
//  _onHeroTap(BuildContext context, int heroID) {
    Navigator.pushNamed(context, HeroDetailRoute, arguments: {"hero": hero});
//    Navigator.pushNamed(context, HeroDetailRoute, arguments: {"id": heroID});
  }
}
