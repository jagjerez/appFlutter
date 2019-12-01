import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:parte_smmsl/Control/AppBarUser2.dart';
import 'package:parte_smmsl/Control/JGTextNumberFormat.dart';
import 'package:parte_smmsl/Streams/ClockStream.dart';

import '../Mediasquery.dart';
import '../pages/FormHoras.dart';

class FormHorasState extends State<FormHoras> {
  String user_id;
  FormHorasState(this.user_id);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  int diff;
  String stateBtn = "Stop";
  String _razon = "";
  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarUser2(height: 50,),
      body:StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('days').snapshots(),
        builder: (context,t){
          if(t.hasError){
            return Text('Error ${t.error}');
          }
          switch(t.connectionState){
            case ConnectionState.waiting:
              return Text('Espere...');
            default:
              return ListView(
                children: t.data.documents.where((e)=> e.documentID == user_id).map((DocumentSnapshot doc){
                  return Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(Mediasquery.k(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width:Mediasquery.widthComplementHour(context),
                              child:
                              Text(
                                "Enterprise: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:  Mediasquery.fontSizeComplementListDaysWork(context)
                                ),
                              ),
                            ),
                            Container(
                                width:Mediasquery.widthTextHour(context),
                                child:Text(
                                  doc['enterprise'],
                                  style: TextStyle(
                                    fontSize: Mediasquery.fontSizeComplementListDaysWork(context),
                                  ),
                                  textAlign: TextAlign.left,
                                )
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(Mediasquery.k(context),0, Mediasquery.k(context), Mediasquery.k(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width:Mediasquery.widthComplementHour(context),
                              child:
                              Text(
                                "Create Date: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Mediasquery.fontSizeComplementListDaysWork(context)
                                ),
                              ),
                            ),
                            Container(
                              width:Mediasquery.widthTextHour(context),
                              child:
                              Text(
                                DateFormat("dd/MM/yyyy").format( doc['start'].toDate()),
                                style: TextStyle(
                                    fontSize: Mediasquery.fontSizeComplementListDaysWork(context)
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(Mediasquery.k(context),0, Mediasquery.k(context), Mediasquery.k(context)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width:Mediasquery.widthComplementHour(context),
                              child:
                              Text(
                                "Init Hour: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Mediasquery.fontSizeComplementListDaysWork(context)
                                ),
                              ),
                            ),
                            Container(
                              width:Mediasquery.widthTextHour(context),
                              child:
                              Text(
                                DateFormat("HH:mm:ss").format( doc['start'].toDate()),
                                style: TextStyle(
                                    fontSize: Mediasquery.fontSizeComplementListDaysWork(context)
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(Mediasquery.k(context),0, Mediasquery.k(context), Mediasquery.k(context)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width:Mediasquery.widthComplementHour(context),
                              child:
                              Text(
                                "State: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Mediasquery.fontSizeComplementListDaysWork(context)
                                ),
                              ),
                            ),
                            Container(
                              width:Mediasquery.widthTextHour(context),
                              child:
                              Text(
                                (doc['state']!="end"?doc['state']:'${doc['state']} - ${new DateFormat('dd/MM/yyyy HH:mm:ss').format(new DateTime.fromMillisecondsSinceEpoch(doc['start'].toDate().millisecondsSinceEpoch + doc['accumulate'],isUtc: true))}'),
                                style: TextStyle(
                                    fontSize: Mediasquery.fontSizeComplementListDaysWork(context),
                                    color: doc['state'] == "end"? Colors.blueAccent:doc['state']== "active"? Colors.green:Colors.red
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(Mediasquery.k(context),0, Mediasquery.k(context), Mediasquery.k(context)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width:Mediasquery.widthComplementHour(context),
                              child:
                              Text(
                                "Description: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Mediasquery.fontSizeComplementListDaysWork(context)
                                ),
                              ),
                            ),
                            Container(
                              width:Mediasquery.widthTextHour(context),
                              child:
                              Text(
                                doc['description'],
                                style: TextStyle(
                                    fontSize: Mediasquery.fontSizeComplementListDaysWork(context),
                                    color: Colors.black87
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          child:StreamBuilder<DateTime>(
                            stream: ClockStream().time(doc['state']=="active"?false:true).stream,
                            builder: (context,value) {
                              if(value.hasError){
                                return Text('Error ${value.error}');
                              }
                              //var compare = fechaInit.compareTo(value.data);
                              switch(value.connectionState)
                                  {
                                case ConnectionState.waiting:
                                  /*var algo = 0;
                                  Firestore.instance.collection('times').where((DocumentSnapshot e)=> e.data['day_id'] == user_id)..then((v){

                                  }).whenComplete((){
                                    return JGTextNumberFormat(new DateFormat('HH:mm:ss').format(new DateTime.fromMillisecondsSinceEpoch(doc['accumulate'],isUtc: true)),65.0);
                                  });*/
                                  return JGTextNumberFormat(new DateFormat('HH:mm:ss').format(new DateTime.fromMillisecondsSinceEpoch(doc['accumulate'],isUtc: true)),65.0);
                                default:
                                  //this.diff = value.data.millisecondsSinceEpoch;
                                  diff = (value.data.millisecondsSinceEpoch - doc['init'].toDate().millisecondsSinceEpoch);
                                  return  JGTextNumberFormat(new DateFormat('HH:mm:ss').format(new DateTime.fromMillisecondsSinceEpoch(diff,isUtc: true)),65.0);
                              }
                            },
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  top: new BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 20, 79, 203),
                                      style: BorderStyle.solid
                                  )
                              )
                          )
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(Mediasquery.k(context),0, Mediasquery.k(context), Mediasquery.k(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              //width:Mediasquery.widthTextHour(context),
                                margin: EdgeInsets.all(Mediasquery.k(context)),
                                child:
                                FlatButton(

                                  color: Color.fromARGB(255, 20, 79, 203),
                                  textColor: Colors.white,
                                  disabledColor: Colors.blueGrey,
                                  disabledTextColor: Colors.white70,
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: Colors.blueAccent,
                                  onPressed: doc['state']=='active' || doc['state']=='stop' ?(){
                                    if(doc['state'] == 'stop'){
                                      _displaySnackBar(context,'Creaing Data');
                                      Firestore.instance.collection("days").document(user_id).updateData({'state':'active','init':DateTime.now()}).then((value){
                                        _hideSnackBar();
                                        _displaySnackBarColor(context,'ok',Colors.green);
                                        //Navigator.of(context).pop();
                                      }).catchError((e){
                                        _displaySnackBarColor(context,'Error',Colors.red);
                                      });
                                    }

                                    if(doc['state'] == 'active')
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return Form(
                                            key: _formKey,
                                            child: AlertDialog(
                                              title: Text("Write a reason of close."),
                                              content: Container(
                                                height: 75,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      child: TextFormField(
                                                        onChanged: (input)=> _razon = input,
                                                        decoration: InputDecoration(
                                                          labelText: 'Reason',
                                                        ),
                                                        validator: validationText,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  onPressed: (){
                                                  if (_formKey.currentState.validate()) {
                                                    _formKey.currentState.save();
                                                    _displaySnackBar(context,'Creaing Data');
                                                    Firestore.instance.collection("times").add({
                                                      'day_id': user_id,
                                                      'acumulate':diff,
                                                      'razon':_razon
                                                    }).then((value){

                                                      Firestore.instance.collection("days").document(user_id).get().then((s){
                                                        Firestore.instance.collection('days').document(user_id).updateData({'accumulate':s.data['accumulate'] + diff,'state':'stop'}).whenComplete((){
                                                          //Scaffold.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
                                                          _hideSnackBar();
                                                          Navigator.of(context).pop();
                                                        }).catchError((e){
                                                          _hideSnackBar();
                                                          _displaySnackBarColor(context,'Error',Colors.red);
                                                        });
                                                      }).catchError((e){
                                                        _hideSnackBar();
                                                        _displaySnackBarColor(context,'Error',Colors.red);
                                                      });


                                                    }).catchError((e){
                                                      _hideSnackBar();
                                                      _displaySnackBarColor(context,'Error',Colors.red);
                                                    });

                                                  }

                                                  },
                                                  child: Text("Continue"),
                                                ),
                                                FlatButton(
                                                  onPressed: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Close"),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      );
                                  }:null,
                                  child: Text(
                                      doc['state'] == 'active'?'Stop':'Continue'
                                  ),

                                )
                            ),
                            Container(
                              //width:Mediasquery.widthTextHour(context),
                              margin: EdgeInsets.all(Mediasquery.k(context)),
                              child:
                              FlatButton(

                                color: Color.fromARGB(255, 20, 79, 203),
                                textColor: Colors.white,
                                disabledColor: Colors.blueGrey,
                                disabledTextColor: Colors.white70,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                onPressed: doc['state']=='active'?((){
                                  Firestore.instance.collection("days").document(user_id).updateData({'state':'end'});
                                }):null,
                                child: Text(
                                    "Finalizar"
                                ),

                              )
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList()
              );
          }
        },
      ),
    );
  }
  String validationText(String value){
    if(value.isEmpty)
    {
      return 'the field can`t leave empty.';
    }
    return null;
  }
  _displaySnackBar(BuildContext context,String message) {

      final snackBar = SnackBar(content: Text(message));
      _scaffoldKey.currentState.showSnackBar(snackBar);


  }

  _displaySnackBarColor(BuildContext context,String message,Color color) {

      final snackBar = SnackBar(content: Text(message),backgroundColor: color,);
      _scaffoldKey.currentState.showSnackBar(snackBar);


  }

  _hideSnackBar(){

      _scaffoldKey.currentState.hideCurrentSnackBar(reason: SnackBarClosedReason.hide);

  }
}