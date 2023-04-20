import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopapp/shared/constance/constance.dart';

ThemeData LightTheme = ThemeData(
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
     unselectedItemColor: Colors.grey,
    selectedItemColor: primaryColore,
    elevation: 20.0,
    type: BottomNavigationBarType.fixed,
  ) ,
  primarySwatch: primaryColore,
  scaffoldBackgroundColor: Colors.white,//HexColor('333739') ,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor:  Colors.black,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor:Colors.white ,
    elevation: 0,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold
    ),
  ),
);