import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parte_smmsl/Control/AppBarUser3.dart';
import 'package:parte_smmsl/pages/UserAdmin.dart';

import '../pages/EditUser.dart';

class EditUSerState extends State<EditUSer> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final String _displayName;
  final String _password;
  final bool name ;
  final bool pass ;
  String _old_displayName;
  String _old_password;
  EditUSerState(this._displayName,this._password,this.name,this.pass);
  @override
  Widget build(BuildContext context) {
    _old_displayName = _displayName;
    _old_password = _password;
    return Scaffold(
      appBar: AppBarUser3( height: 50,),
      body: Builder(
        builder: (context)=> Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: TextFormField(
                  enabled: name,
                  initialValue: _displayName,
                  validator: ValidationEmail,
                  onChanged: (input)=> _old_displayName = input,
                  decoration: InputDecoration(
                    labelText: 'Display Name',
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(100, 25, 100, 50),
                  child:FlatButton(
                    color: Color.fromARGB(255, 20, 79, 203),
                    textColor: Colors.white,
                    disabledColor: Colors.blueGrey,
                    disabledTextColor: Colors.white70,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: ()=> Save(context),
                    child: Text(
                        "Save"
                    ),

                  )
              )
            ],
          ),
        ),
      )
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
    if (_password != value){
      if(value.length < 6)
      {
        return 'the field is`t value valid.';
      }
    }

    return null;
  }
  Future<void> Save (BuildContext context) async{
    //FirebaseAuth.instance.signOut();
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      _formKey.currentState.save();
      final snack = new SnackBar(
          content: Text('Processing Data')
      );
      try
      {
        Scaffold
            .of(context)
            .showSnackBar(
            snack
        );
        if (name){
          User user = FirebaseAuth.instance.currentUser;
          /*UserUpdateInfo userinfo = new UserUpdateInfo();
          userinfo.displayName = _old_displayName;*/
          await user.updateDisplayName(_old_displayName);
        }
        //AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        //snack.action.onPressed();
        Scaffold.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> UserAdmin()));
      }catch(e){
        Scaffold
            .of(context)
            .showSnackBar(SnackBar(
            content: Text(e.message),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red
        ));
        Navigator.pop(context);
      }

      //Scaffold.of(context).

    }

  }
}