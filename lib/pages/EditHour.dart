import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parte_smmsl/Control/AppBarUser2.dart';

class EditHour extends StatefulWidget {
  @override
  _EditHourState createState() => _EditHourState();
}

class _EditHourState extends State<EditHour> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _enterprise;
  String _description;
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
                margin: EdgeInsets.fromLTRB(45, 0, 45, 0),
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
                margin: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: TextFormField(
                  validator: validationText,
                  onChanged: (input)=> _enterprise = input,
                  decoration: InputDecoration(
                    labelText: 'Enterprise',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(45, 0, 45, 0),
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
          content: Text('Creating User')
      );
      try
      {
        Scaffold
            .of(context)
            .showSnackBar(
            snack
        );
        FirebaseUser result = await FirebaseAuth.instance.currentUser();
        String day = '${new DateFormat("E").format(DateTime.now())}day';
        Firestore.instance.collection("days").add({
          'day':day,
          'description':_description,
          'enterprise':_enterprise,
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
