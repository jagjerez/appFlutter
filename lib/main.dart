import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parte_smmsl/pages/FormHoras.dart';
import 'package:parte_smmsl/pages/ListDaysWork.dart';
import 'package:flutter/src/widgets/app.dart';
import 'pages/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<FirebaseApp>(
      stream: Firebase.initializeApp().asStream(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Scaffold(
                  body: Text('Error al cargar firebase'))
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              //home: MyHomePage(title: 'Flutter Demo Home Page'),
              home: StreamBuilder<User>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context,data){
                  if(data.hasData){
                    return ListDaysWork(user: data.data,);
                  }
                  return Scaffold(
                      body: MyHomePage(title:'Login Page'));
                },
              )
          );
          return Text('Espere...');
        }
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Scaffold(
                body: Text('Espere...'))
        );
      },
    );
  }
}




