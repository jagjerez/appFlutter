import 'package:flutter/material.dart';

import '../state/EditUserState.dart';

class EditUSer extends StatefulWidget {
  final String displayName ;
  final String password ;
  final bool name ;
  final bool pass ;
  EditUSer(this.displayName,this.password,this.name,this.pass);
  @override
  EditUSerState createState() => EditUSerState(displayName,password,name,pass);
}


