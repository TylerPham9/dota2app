import 'package:flutter/material.dart';
import 'package:dota2app/models/Hero.dart';

class HeroDetail extends StatelessWidget {
  final DotaHero _dotaHero;
  HeroDetail(this._dotaHero);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_dotaHero.localizedName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
                constraints: BoxConstraints.expand(
                  height: 144.0,
                  width: 256.0,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_dotaHero.img),
                    fit: BoxFit.fill,
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AttributeDetail('str', _dotaHero.baseStr, _dotaHero.strGain,
                  _dotaHero.primaryAttr),
              AttributeDetail('agi', _dotaHero.baseAgi, _dotaHero.agiGain,
                  _dotaHero.primaryAttr),
              AttributeDetail('int', _dotaHero.baseInt, _dotaHero.intGain,
                  _dotaHero.primaryAttr),
            ],
          )
        ],
      ),
    );
  }
}

class AttributeDetail extends StatelessWidget {
  final String _attr;
  final int _attrBase;
  final double _attrGain;
  final String _primaryAttr;
  final colorMap = {'str': Colors.red, 'agi': Colors.green, 'int': Colors.blue};

  AttributeDetail(
      this._attr, this._attrBase, this._attrGain, this._primaryAttr);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            (_attr == _primaryAttr) ? Icons.favorite : Icons.favorite_border,
            size: 30.0,
          ),
        ),
        Row(
          children: <Widget>[
            Container(
                child: Text(_attrBase.toString(),
                    style: TextStyle(color: colorMap[_attr]))),
            Container(child: Text(' + ' + _attrGain.toString())),
          ],
        )
      ],
    );
  }
}
