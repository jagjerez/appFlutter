import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/SignUp.dart';

class SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
        backgroundColor: Color.fromARGB(255, 20, 79, 203),
      ),
      body: Builder(
        builder: (context)=>Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Text(
                          "MASTERTOOLS-DAY",
                          style: TextStyle(

                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth  = 2
                                ..color  = Color.fromARGB(255, 0, 0, 0)
                          ),
                        ),
                        Text(
                          "MASTERTOOLS-DAY",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Color.fromARGB(255, 20, 79, 203)
                          ),
                        ),

                      ],
                    ),
                    Icon(
                      Icons.settings,
                      color: Colors.blueGrey,
                      size: 35.0,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: TextFormField(
                  validator: ValidationEmail,
                  onChanged: (input)=> _email = input,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: TextFormField(
                  validator: ValidationPasswpord,
                  onChanged: (input) => _password = input,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: TextFormField(
                  validator: ValidationPasswpordRepeat,
                  decoration: InputDecoration(
                    labelText: 'Repeat Password',
                  ),
                  obscureText: true,
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
                        "SignUp"
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
  String ValidationEmail(String value){
    if(value.isEmpty)
    {
      return 'the field can`t leave empty.';
    }
    return null;
  }
  String ValidationPasswpord(String value){
    if(value.isEmpty || value.length < 6)
    {
      return 'the field isn`t value valid.';
    }
    return null;
  }

  String ValidationPasswpordRepeat(String value){
    if(_password != value)
    {
      return 'the password isn`t equal.';
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
        UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
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