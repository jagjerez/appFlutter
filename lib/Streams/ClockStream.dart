
import 'dart:async';

class ClockStream{

 StreamController<DateTime> time(bool stop) {
   StreamController<DateTime> controller = new StreamController<DateTime>();
   Timer.periodic(Duration(seconds: 1),(Timer timer) {
     if(!stop){

       controller.add(DateTime.now());
     }
     else
     {
      timer.cancel();
     }

   });
   return controller;
 }

 void ok(){

 }

}