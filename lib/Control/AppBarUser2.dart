import 'package:flutter/material.dart';

import '../Mediasquery.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AppBarUser2 extends StatelessWidget implements PreferredSizeWidget{

  final double height;

  const AppBarUser2({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


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
      backgroundColor: Color.fromARGB(255, 20, 79, 203),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(height);
}