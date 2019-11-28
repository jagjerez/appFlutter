

import 'package:flutter/material.dart';

import 'package:parte_smmsl/pages/EditEnterprise.dart';


import '../Mediasquery.dart';

class JGItemEnterprise extends StatelessWidget{
  String userId;
  String name;
  String address;
  int diff;
  String  desc_rela;
  String documentID;
  JGItemEnterprise(this.userId, this.name,this.address,this.desc_rela,this.documentID);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Txt = Container(
        height: Mediasquery.heigthListEnterprise(context),
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
          padding: EdgeInsets.all(Mediasquery.marginListEnterprise(context)),
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      width: Mediasquery.widthComplementListEnterprise(context),
                      child:Text(
                        "Name: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Mediasquery.fontSizeComplementListEnterprise(context)
                        ),

                      )
                  ),
                  Container(
                      width: Mediasquery.widthTextListEnterprise(context),
                      child:Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: Mediasquery.fontSizeTextListEnterprise(context)
                        ),
                      )

                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                      width: Mediasquery.widthComplementListEnterprise(context),
                      child:Text(
                        "Address: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Mediasquery.fontSizeComplementListEnterprise(context),
                            color: Colors.black87
                        ),
                      ),
                  ),
                  Container(
                      width: Mediasquery.widthTextListEnterprise(context),
                      child:Text(
                        address,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Mediasquery.fontSizeTextListEnterprise(context),
                            color: Colors.black54
                        ),
                      )
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                     // margin: EdgeInsets.fromLTRB(0, 10, 25.0, 0),
                      child: Text(
                        'Description: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Mediasquery.fontSizeComplementListEnterprise(context),
                            color: Colors.black87
                        ),
                      )
                  ),
                  Container(
                      //margin: EdgeInsets.fromLTRB(0, 10, 25.0, 0),
                      child: Text(
                        desc_rela,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Mediasquery.fontSizeTextListEnterprise(context),
                            color:  Colors.black54
                        ),
                      )
                  )
                ],
              )
            ],
          ),
          onPressed: ()
          {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditEnterprise(enterprise: name,address: address,description: desc_rela,documentID: documentID,viene: 'editar',)));
          },
        )
    );
    return Txt;
  }
}