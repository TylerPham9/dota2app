import 'package:flutter/material.dart';
import 'package:dota2app/style.dart';

class AttributeDetail extends StatelessWidget {
  final String _attr;
  final int _attrBase;
  final double _attrGain;
  final String _primaryAttr;
  final iconMap = {
    'str': "assets/icons/strIcon.png",
    'agi': "assets/icons/agiIcon.png",
    'int': "assets/icons/intIcon.png",
  };

  AttributeDetail(
      this._attr, this._attrBase, this._attrGain, this._primaryAttr);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
                width: 45.0,
                height: 45.0,
                child: DecoratedBox(decoration: getAttrIcon()))),
        Row(
          children: <Widget>[
            Container(
                child: Text(_attrBase.toString(),
                    style: TextStyle(color: attrColors[_attr]))),
            Container(child: Text(' + ' + _attrGain.toString())),
          ],
        )
      ],
    );
  }

  BoxDecoration getAttrIcon() {
    return BoxDecoration(
        image: DecorationImage(
            image: AssetImage(iconMap[_attr]), fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(45.0)),
        border: new Border.all(
            color: (_attr == _primaryAttr) ? Colors.amber : Colors.black,
            width: 2.0));
  }
}
