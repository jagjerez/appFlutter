import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../state/listenterprisestate.dart';

class listenterprise extends StatefulWidget {
  listenterprise({Key key, this.title,this.user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  FirebaseUser user;

  @override
  listenterprisestate createState() => listenterprisestate(user);
}