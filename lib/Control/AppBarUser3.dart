import 'package:flutter/material.dart';

import '../Mediasquery.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:parte_smmsl/pages/UserAdmin.dart';

class AppBarUser3 extends StatelessWidget implements PreferredSizeWidget{

  final double height;

  const AppBarUser3({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var media = MediaQuery.of(context).size;

    return AppBar(
      title: StreamBuilder<FirebaseUser>(
        stream : FirebaseAuth.instance.currentUser().asStream(),
        builder: (BuildContext context,AsyncSnapshot<FirebaseUser> user){
          if(user.hasError){
            return Text('No login');
          }
          if(user.connectionState == ConnectionState.waiting){
            return Text('Espere...');
          }
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('MasterTools-Day'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'User: ',
                      style: TextStyle(
                          fontSize: Mediasquery.fontSizeComplement(context),
                        color: Colors.white70
                      ),
                    ),
                    Text(
                      (user.data.displayName == null? user.data.email : user.data.displayName),
                      style: TextStyle(
                          fontSize: Mediasquery.fontSizeComplement(context)
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
      leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> UserAdmin()));
          },
        ),
      backgroundColor: Color.fromARGB(255, 20, 79, 203),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(height);
}