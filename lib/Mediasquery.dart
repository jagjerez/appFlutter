import 'package:flutter/material.dart';


class Mediasquery {
  static Size media(BuildContext context) => MediaQuery.of(context).size;
  static  double k(BuildContext context) => (media(context).width * 0.02);
  static  double marginEditEnterprise(BuildContext context) => (media(context).width * 0.08);
  static  double widthIconEditEnterprise(BuildContext context) => (media(context).width * 0.082);
  static  double widthComplement(BuildContext context) => media(context).width < 600?(media(context).width * 0.19)- k(context):media(context).width*0.25 - k(context);
  static  double fontSizeComplement(BuildContext context) => media(context).width *0.033;
  static  double widthText(BuildContext context) => media(context).width < 600?media(context).width - ((media(context).width * 0.19) * 2)- k(context):media(context).width - ((media(context).width*0.25) * 2) - k(context);
  static  double fontSizeText(BuildContext context) => media(context).width *0.043;
  static  double marginListDaysWork(BuildContext context) => media(context).width * 0.025;
  static  double fontSizeComplementListDaysWork(BuildContext context) => media(context).width * 0.038;
  static  double fontSizeTextListDaysWork(BuildContext context) => media(context).width * 0.048;
  static  double heigthListDaysWork(BuildContext context) => media(context).width * 0.175;
  static  double marginRigthTextListDaysWork(BuildContext context) => media(context).width * 0.048;
  static  double fontSizeTitleAppBar(BuildContext context) => media(context).width * 0.048;
  static  double fontSizeComplementAppBar(BuildContext context) => media(context).width * 0.048;
  static  double widthComplementHour(BuildContext context) => media(context).width < 600?(media(context).width * 0.25)- k(context):media(context).width*0.29 - k(context);
  static  double widthTextHour(BuildContext context) => media(context).width < 600?media(context).width - ((media(context).width * 0.25))- k(context):media(context).width - ((media(context).width*0.29)) - k(context);
  static  double marginListEnterprise(BuildContext context) => media(context).width * 0.025;
  static  double marginRigthTextListEnterprise(BuildContext context) => media(context).width * 0.048;
  static  double fontSizeComplementListEnterprise(BuildContext context) => media(context).width * 0.035;
  static  double fontSizeTextListEnterprise(BuildContext context) => media(context).width * 0.038;
  static  double heigthListEnterprise(BuildContext context) => media(context).width * 0.185;
  static  double widthComplementListEnterprise(BuildContext context) => media(context).width < 600?(media(context).width * 0.17)- marginListEnterprise(context):media(context).width*0.22 - marginListEnterprise(context);
  //static  double fontSizeComplementListEnterprise(BuildContext context) => media(context).width *0.033;
  static  double widthTextListEnterprise(BuildContext context) => media(context).width < 600?media(context).width - ((media(context).width * 0.17))- marginListEnterprise(context):media(context).width - ((media(context).width*0.23) * 1) - marginListEnterprise(context);
  //static  double fontSizeTextListEnterprise(BuildContext context) => media(context).width *0.043;
}