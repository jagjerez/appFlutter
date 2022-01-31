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
  int diff;
  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBarUser2(height: 50,),
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('days').snapshots(),
        builder: (context,t){
          if(t.hasError){
            return Text('Error ${t.error}');
          }
          switch(t.connectionState){
            case ConnectionState.waiting:
              return Text('Espere...');
            default:
              return ListView(
                children: t.data.docs.where((e)=> e.id == user_id).map((QueryDocumentSnapshot document){
                  final Map<String,dynamic> doc = document.data();
                  final DocumentReference ref = doc['enterprise_id'];
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
                                child:StreamBuilder<DocumentSnapshot>(
                                  stream: ref.get().asStream(),
                                  builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){

                                    if(snapshot.hasError){
                                      return Text('Error ${snapshot.error}');
                                    }
                                    if(snapshot.data != null){
                                      final Map<String,dynamic> document = snapshot.data.data();
                                      return Text(
                                        document['name'],
                                        style: TextStyle(
                                          fontSize: Mediasquery.fontSizeComplementListDaysWork(context),
                                        ),
                                        textAlign: TextAlign.left,
                                      );
                                    }
                                    return Text('Espere...');
                                  },
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
                            builder: (context,value){
                              if(value.hasError){
                                return Text('Error ${value.error}');
                              }
                              //var compare = fechaInit.compareTo(value.data);
                              switch(value.connectionState)
                                  {
                                case ConnectionState.waiting:
                                  return JGTextNumberFormat(new DateFormat('HH:mm:ss').format(new DateTime.fromMillisecondsSinceEpoch(doc['accumulate'],isUtc: true)),65.0);
                                default:
                                  //this.diff = value.data.millisecondsSinceEpoch;
                                  diff = (value.data.millisecondsSinceEpoch - doc['start'].toDate().millisecondsSinceEpoch);
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
                                onPressed: doc['state']=='active'?((){
                                  FirebaseFirestore.instance.collection("days").doc(user_id).update({'accumulate':diff,'state':'end'});
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
}