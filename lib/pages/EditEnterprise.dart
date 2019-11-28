import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parte_smmsl/Control/AppBarUser2.dart';

import '../Mediasquery.dart';

class EditEnterprise extends StatefulWidget {
  //EditEnterprise({Key key,this._enterprise,this._address,this._description,this.documentID,this.viene}): super();
  EditEnterprise({Key key, this.enterprise,this.address,this.description,this.documentID,this.viene}) : super(key: key);
  String enterprise;
  String address;
  String description;
  String documentID;
  String viene;
  @override
  _EditEnterpriseState createState() => _EditEnterpriseState(enterprise,address,description,documentID,viene);
}

class _EditEnterpriseState extends State<EditEnterprise> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _enterprise;
  String _address;
  String _description;
  String documentID;
  String viene;
  _EditEnterpriseState(this._enterprise,this._address,this._description,this.documentID,this.viene);
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
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(Mediasquery.marginEditEnterprise(context), 0, Mediasquery.marginEditEnterprise(context), 0),
                child:TextFormField(
                  initialValue: _enterprise,
                  validator: validationText,
                  onChanged: (input)=> _enterprise = input,
                  decoration: InputDecoration(
                    labelText: 'Enterprise Name',
                  ),
                )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(Mediasquery.marginEditEnterprise(context), 0, Mediasquery.marginEditEnterprise(context), 0),
                child: TextFormField(
                  initialValue: _address,
                  validator: validationText,
                  onChanged: (input)=> _address = input,
                  decoration: InputDecoration(
                    labelText: 'Address Enterprise',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(Mediasquery.marginEditEnterprise(context), 0, Mediasquery.marginEditEnterprise(context), 0),
                child: TextFormField(
                  initialValue: _description,
                  validator: validationText,
                  onChanged: (input) => _description = input,
                  decoration: InputDecoration(
                    labelText: 'Descripcion Relacion with you',
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
                        "Create Enterprise"
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
    if(value.length > 40)
    {
      return 'the field should can`t more 40 caracters .';
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
        if (viene == "editar"){
          Firestore.instance.collection("enterprises").document(documentID).updateData({
            'name':_enterprise,
            'desc_rela':_description,
            'address':_address
          });
        }
        else{
          FirebaseUser result = await FirebaseAuth.instance.currentUser();
          //String day = '${new DateFormat("E").format(DateTime.now())}day';
          Firestore.instance.collection("enterprises").add({
            'name':_enterprise,
            'desc_rela':_description,
            'address':_address,
            'user_id':result.uid
          });
        }

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
