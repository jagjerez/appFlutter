
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../pages/SignUp.dart';
import 'dart:async';

import '../pages/MyHomePage.dart';

import '../Services/Auth.dart';


class MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final auth = new Auth();
  String _email;
  String _password;
  @override
  void initState(){
    //var v = PackageInfoCompat.getLongVersionCode(getPackageManager().getPackageInfo(GoogleApiAvailability.GOOGLE_PLAY_SERVICES_PACKAGE, 0 ));
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Form(
              key: _formKey,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   //JGTextBox("Escriba su Usuario",75.0,75.0),
                   //JGTextBox("Escriba su Contraseña",75.0,75.0),
                   Container(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Stack(
                           children: <Widget>[
                             Text(
                               "MASTERTOOLS-FICHAJES",
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
                               "MASTERTOOLS-FICHAJES",
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
                       onSaved: (input) => _password = input,
                       decoration: InputDecoration(
                         labelText: 'Password',
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
                           onPressed: SignIn,
                           child: Text(
                               "SignIn"
                           ),

                         )
                       ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       FlatButton(
                         child: Text(
                             'SignUp',
                           style: TextStyle(
                             color: Colors.grey,
                             fontSize: 15
                           ),
                         ),
                         onPressed: (){
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
                         },
                       )
                     ],
                   )
                 ],
               ),
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
      return 'the field is`t value valid.';
    }
    return null;
  }
  Future<void> SignIn () async{
    FirebaseAuth.instance.signOut();
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
        UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        //snack.action.onPressed();
        Scaffold.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ListDaysWork(user: result.user,)));
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