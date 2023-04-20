import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shopapp/modules/login_Screen/Login_Screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cashe_helper.dart';

MaterialColor primaryColore =Colors.blue;

String? token = '';

void Logout(context){
  CasheHelper.removeData(key:'token').then((value) {
    if(value){
      NavigateAndFinish(
        context ,
        LoginScreen(),
      );
    }
  });
}
