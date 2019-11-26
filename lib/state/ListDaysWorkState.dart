import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parte_smmsl/Control/AppBarUser.dart';
import 'package:parte_smmsl/Control/JGItemDaysWork.dart';
import 'package:parte_smmsl/pages/EditHour.dart';


import '../pages/ListDaysWork.dart';

class ListDaysWorkState extends State<ListDaysWork> {
  FirebaseUser user;
  ListDaysWorkState(this.user);



  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBarUser(height: 50,),
        body:Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('days').snapshots(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasError){
                return Text('Error ${snapshot.error}');
              }

              switch(snapshot.connectionState){
                case ConnectionState.waiting: return Text('Loading...');
                default:
                  return  ListView(
                    children: snapshot.data.documents.where((e)=>e['user_id'] == this.user.uid).map((DocumentSnapshot document){

                      return JGItemDaysWork(
                          document['user_id'],
                          document['enterprise_id'],
                          document['day'],
                          document['start'].toDate() ,
                          document['diff'],
                          document['state'],
                          document.documentID
                      );
                    }).toList()
                  );
              }
            },
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 20, 79, 203),
        splashColor: Colors.blueAccent,
        child:  Icon(
              Icons.add,
              color: Colors.white,
              size: 25.0,
            ),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditHour()));
        },
      ),
    );
  }
}