import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';

const ImageHost = 'http://cdn.dota2.com';


class Heroes extends StatelessWidget{
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
          crossAxisCount: 4,
          children: heroHub.heroes
              .map((hero) => Padding(
              padding: const EdgeInsets.all(1.0),
              child: InkWell(
                onTap: (){
                  print(hero.localizedName + ' tapped');
                },
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(ImageHost+hero.img),
                                fit: BoxFit.cover)
                        ),
                      ),
                      Text(
                        hero.localizedName,
                        textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              )))
              .toList(),
        ));
  }

}