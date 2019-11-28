

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parte_smmsl/Control/AppBarUser2.dart';

import '../Mediasquery.dart';

class EditHour extends StatefulWidget {
  EditHour({Key key, @required this.user_id}) : super(key: key);
  String user_id;
  @override
  _EditHourState createState() => _EditHourState(this.user_id);
}

class _EditHourState extends State<EditHour> {
  String _user_id;
  _EditHourState(this._user_id);
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _enterprise;
  String _description;
  String _enterprise_id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser2(height: 50),
      body: Builder(
        builder: (context)=>Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(Mediasquery.marginEditEnterprise(context), 0, Mediasquery.marginEditEnterprise(context), 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Day of Week: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                    Text(
                      '${new DateFormat("E").format(DateTime.now())}day',
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 18
                        )
                    ),
                  ],
                )
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(Mediasquery.marginEditEnterprise(context), 0, Mediasquery.marginEditEnterprise(context), 0),
                  child:StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('enterprises').snapshots(),
                    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasError){
                        return Text('Error ${snapshot.error}');
                      }

                      switch(snapshot.connectionState){
                        case ConnectionState.waiting: return Text('Loading...');
                        default:
                          return  DropdownButton(
                            value: _enterprise,
                            hint: Container(
                              width: MediaQuery.of(context).size.width - (Mediasquery.marginEditEnterprise(context) * 2) - Mediasquery.widthIconEditEnterprise(context),
                              child:  Text("Seleccione..."),
                            ),
                            icon: Container(
                              //width: Mediasquery.widthIconEditEnterprise(context),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black87,
                                size: Mediasquery.widthIconEditEnterprise(context),
                              ),
                            ),
                            iconDisabledColor: Colors.grey,
                            iconEnabledColor: Colors.white,
                            underline: Container(
                              height: 1,
                              color: Colors.black45,
                            ),
                            elevation: 16,
                            onChanged: (String newValue)  async{
                              _enterprise_id = newValue;
                              //DocumentSnapshot s = await Firestore.instance.collection('enterprises').document(_enterprise_id).snapshots().first;
                              setState(() {
                                _enterprise = _enterprise_id;
                              });
                            },
                            items: snapshot.data.documents.where((e)=>e["user_id"] == this._user_id).map((DocumentSnapshot document){

                              return DropdownMenuItem(
                                value: document.documentID,
                                child:Container(
                                  width: MediaQuery.of(context).size.width - (Mediasquery.marginEditEnterprise(context) * 2) - Mediasquery.widthIconEditEnterprise(context),
                                  child: Text(document["name"]),
                                ),
                              );
                            }).toList(),
                          ); /*<String>['One', 'Two']
                        .map<DropdownMenuItem<String>>((String value) {


                    }).toList()*/
                      }
                    },
                  )
                /*TextFormField(
                  initialValue: _enterprise,
                  validator: validationText,
                  onChanged: (input)=> _enterprise = input,
                  decoration: InputDecoration(
                    labelText: 'Enterprise Name',
                  ),
                ),*/
              ),
              Container(
                margin: EdgeInsets.fromLTRB(Mediasquery.marginEditEnterprise(context), 0, Mediasquery.marginEditEnterprise(context), 0),
                child: TextFormField(
                  validator: validationText,
                  onChanged: (input) => _description = input,
                  decoration: InputDecoration(
                    labelText: 'Descripcion',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    color: Color.fromARGB(255, 20, 79, 203),
                    textColor: Colors.white,
                    disabledColor: Colors.blueGrey,
                    disabledTextColor: Colors.white70,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: ()=> SignUp(context),
                    child: Text(
                        "Create Time Part"
                    ),

                  )
                ],
              ),
            ],
          ),
        ),
      ) ,
    );
  }
  String validationText(String value){
    if(value.isEmpty)
    {
      return 'the field can`t leave empty.';
    }
    return null;
  }
  Future<void> SignUp (BuildContext context) async{
    //FirebaseAuth.instance.signOut();
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      _formKey.currentState.save();
      final snack = new SnackBar(
          content: Text('Creating Data')
      );
      try
      {
        Scaffold
            .of(context)
            .showSnackBar(
            snack
        );
        DocumentSnapshot s = await Firestore.instance.collection('enterprises').document(_enterprise_id).snapshots().first;

        FirebaseUser result = await FirebaseAuth.instance.currentUser();
        String day = '${new DateFormat("E").format(DateTime.now())}day';
        Firestore.instance.collection("days").add({
          'day':day,
          'description':_description,
          'enterprise':s['name'],
          'enterprise_id':_enterprise_id,
          'start':DateTime.now(),
          'state':'active',
          'user_id':result.uid,
          'accumulate':0
        });
        //AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        //snack.action.onPressed();
        Scaffold.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
        Navigator.of(context).pop();
      }catch(e){
        Scaffold
            .of(context)
            .showSnackBar(SnackBar(
            content: Text(e.message),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red
        ));

      }

      //Scaffold.of(context).

    }

  }
}
