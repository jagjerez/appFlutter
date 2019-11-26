import 'dart:ffi';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

class JGTextNumberFormat extends StatelessWidget{

    String hora;
    double fontSize;
    JGTextNumberFormat(this.hora,this.fontSize);

    @override
    Widget build(BuildContext context) {
    // TODO: implement build
      final Txt = Center(
        child:Column(
          children: <Widget>[
            Container(
              child: Text('Time Transcurred'),
            ),
            Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      hora,
                      style: TextStyle(
                          fontSize: fontSize
                      ),
                    ),
                  ],
                )
            )
          ],
        )
      );

    return Txt;
  }
}