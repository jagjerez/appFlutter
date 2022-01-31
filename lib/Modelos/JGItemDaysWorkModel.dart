
import 'package:cloud_firestore/cloud_firestore.dart';

class JGItemDaysWorkModel{
  int userId;
  DocumentReference enterpriseId;
  int day;
  DateTime start;
  int diff;
  String state;
  String documentId;
}