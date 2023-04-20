import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/Home_Layout/Home_Screen.dart';
import 'package:shopapp/layouts/Home_Layout/home_cupit/home_cubit.dart';
import 'package:shopapp/models/models_response_api/home_model.dart';
import 'package:shopapp/modules/login_Screen/Login_Screen.dart';
import 'package:shopapp/shared/constance/constance.dart';
import 'package:shopapp/shared/network/cloud/dio_helper.dart';
import 'package:shopapp/shared/network/local/cashe_helper.dart';
import 'package:shopapp/shared/styles/ThemeData.dart';
import 'modules/OnBoardingScreen/OnBoarding_Screen.dart';
import 'shared/cupit/login_cupit/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CasheHelper.init();
  await DioHelper.init();
  bool? onBoarding = CasheHelper.getData(key: 'onBoarding');
  // CasheHelper.removeData(key: 'token');
  token = CasheHelper.getData(key: 'token');
  print(token);

  runApp(MyApp(
    onBoarding: onBoarding,
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  bool? onBoarding;
  String? token;

  MyApp({this.onBoarding, this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (context) => HomeCubit()
            ..getDataHome()
            ..getDataCategory()
            ..getDataFavorite()
            ..getDataProfile(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: LightTheme,
        home: openScreen(),
      ),
    );

  }

  Widget openScreen() {
    if (onBoarding == true) {
      if (token != null) {
        return HomeLayout();
      } else
        return LoginScreen();
    } else
      return OnBoardingScreen();
  }
}
