

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parte_smmsl/pages/FormHoras.dart';

import '../Mediasquery.dart';

class JGItemDaysWork extends StatelessWidget{
  String ref;
  String userId;
  String day;
  DateTime fecha_ini;
  int diff;
  String  state;
  String documentID;
  JGItemDaysWork(this.userId,this.ref, this.day,this.fecha_ini,this.diff,this.state,this.documentID);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Txt = Container(
        height: Mediasquery.heigthListDaysWork(context),
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 20, 79, 203),
              width: 1,
              style: BorderStyle.solid
            )
          )
        ),
        child:FlatButton(
          padding: EdgeInsets.all(Mediasquery.marginListDaysWork(context)),
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, Mediasquery.marginRigthTextListDaysWork(context), 0),
                      child:Text(
                        day,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Mediasquery.fontSizeTextListDaysWork(context)
                        ),

                      )
                  ),
                  Container(
                      child:Text(
                        new DateFormat('dd/MM/yyyy').format(fecha_ini),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Mediasquery.fontSizeTextListDaysWork(context)
                        ),
                      )

                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 25.0, 0),
                      child:Row(
                        children: <Widget>[
                          Text(
                            "Init: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Mediasquery.fontSizeComplementListDaysWork(context),
                                color: Colors.black87
                            ),
                          ),
                          Text(
                            new DateFormat("HH:mm:ss").format(fecha_ini),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Mediasquery.fontSizeComplementListDaysWork(context),
                                color: Colors.black54
                            ),
                          )
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 25.0, 0),
                      child: Row(
                            children: <Widget>[
                              Text(
                                'State: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Mediasquery.fontSizeComplementListDaysWork(context),
                                    color: Colors.black87
                                ),
                              ),
                              Text(
                                state,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Mediasquery.fontSizeComplementListDaysWork(context),
                                    color: state == 'end'? Colors.blueAccent: state == 'active'? Colors.green: Colors.red
                                ),
                              )
                            ])
                      )
                ],
              )
            ],
          ),
          onPressed: ()
          {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FormHoras(user_id: documentID,)));
          },
        )
    );
    return Txt;
  }
}