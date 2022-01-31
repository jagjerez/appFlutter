import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:parte_smmsl/Control/AppBarUser2.dart';
import 'package:parte_smmsl/pages/EditUser.dart';
import '../Mediasquery.dart';

import '../pages/UserAdmin.dart';

class UserAdminState extends State<UserAdmin> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarUser2(height: 50,),
      body: StreamBuilder<User>(
              stream: new Future<User>.value(FirebaseAuth.instance.currentUser).asStream(),
              builder: (BuildContext context,AsyncSnapshot<User> user){
                if(user.hasError){
                  return Text('No login');
                }
                if(user.connectionState == ConnectionState.waiting){
                  return Text('Espere...');
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                   Container(
                     margin: EdgeInsets.all(Mediasquery.k(context)),
                     child:  Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         Container(
                           width:Mediasquery.widthComplement(context),
                           child: Text(
                             'Display Name: ',
                             style: TextStyle(
                                 fontSize: Mediasquery.fontSizeComplement(context),
                                 fontWeight: FontWeight.bold
                             ),

                           ),
                         ),
                         Container(
                           width:Mediasquery.widthText(context),
                           child:Text(
                             (user.data.displayName == null? '' : user.data.displayName),
                             style: TextStyle(
                                 fontSize: Mediasquery.fontSizeText(context),
                                 color: Colors.black54
                             ),

                            )
                         ),
                     Container(
                         width:Mediasquery.widthComplement(context),
                       child:IconButton(
                           icon: Icon(
                             Icons.edit,
                             color: Color.fromARGB(255, 20, 79, 203),
                           ),
                           onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> EditUSer(user.data.displayName == null?"":user.data.displayName,"",true,false)));},
                         )
                        )
                       ],
                     ),
                   ),
                    Container(
                      margin: EdgeInsets.all(Mediasquery.k(context)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width:Mediasquery.widthComplement(context),
                            child: Text(
                              'Email: ',
                              style: TextStyle(
                                  fontSize: Mediasquery.fontSizeComplement(context),
                                  fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                          Container(
                            width:Mediasquery.widthText(context) + Mediasquery.widthComplement(context),
                            child: Text(
                              user.data == null ?'N/A':user.data.email,
                              style: TextStyle(
                                  fontSize: Mediasquery.fontSizeText(context),
                                  color: Colors.black54
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(Mediasquery.k(context)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width:Mediasquery.widthComplement(context),
                            child: Text(
                              'Password: ',
                              style: TextStyle(
                                  fontSize: Mediasquery.fontSizeComplement(context),
                                  fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                          Container(
                              width:Mediasquery.widthText(context),
                              child: Text(
                                '#######',
                                style: TextStyle(
                                    fontSize: Mediasquery.fontSizeText(context),
                                    color: Colors.black54
                                ),
                              )
                          ),
                          Container(
                              width:Mediasquery.widthComplement(context),
                              child:IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 20, 79, 203),
                                ),
                                onPressed: ()=> sendEmail(context),
                              )
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
        );
  }

  void sendEmail(BuildContext context) async{
    try
    {
      Scaffold
          .of(context)
          .showSnackBar(SnackBar(
          content: Text('Sending Email...'),
      ));
      User user = await FirebaseAuth.instance.currentUser;
      await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email);
      Scaffold.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.hide);
      Scaffold
          .of(context)
          .showSnackBar(SnackBar(
          content: Text('Email is send...'),
          backgroundColor: Colors.green
      ));
    }catch(e){
      Scaffold
          .of(context)
          .showSnackBar(SnackBar(
          content: Text(e.message),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red
      ));

    }
  }
}
