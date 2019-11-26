import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:parte_smmsl/Validations/Validaciones.dart';

class JGTextBox extends StatelessWidget{
    final String hintText;
    final double left;
    final double rigth;
    JGTextBox(this.hintText,this.left,this.rigth);
    final validation = new Validaciones();
    @override
    Widget build(BuildContext context) {
    // TODO: implement build
      final Txt = Container(
        padding: EdgeInsets.fromLTRB(75, 0, 75, 0),
        child:TextFormField(
              validator: validation.loginValidation,
              decoration: InputDecoration(
                  hintText: hintText,

              )
        )
      );

    return Txt;
  }
}