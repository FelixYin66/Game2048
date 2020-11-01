import 'package:flutter/material.dart';
import 'tilemodel.dart';
import 'apperance.dart';

class Game2048NumberTitle extends StatelessWidget {

  final TileModel _model;

  Game2048NumberTitle(this._model);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:BorderRadius.all(
          Radius.circular(5),
        ),
        color: AppearanceTheme.getColor(_model.number)
      ),
      child: Center(
        child: Text(str()),
      ),
    );
  }

  String str(){
    return _model.number > 0 ? "${_model.number}" : "";
  }

}
