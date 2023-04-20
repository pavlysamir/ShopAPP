import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/models_response_api/login_model.dart';
import 'package:shopapp/shared/cupit/login_cupit/login_state.dart';
import 'package:shopapp/shared/network/cloud/dio_helper.dart';
import 'package:shopapp/shared/network/cloud/end_points.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  LoginModel? loginModel;

  static LoginCubit? get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    DioHelper.PostData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }


  IconData iconData = Icons.remove_red_eye;
  bool obSurepass = true;

  void isVisibleeye(){

      obSurepass = !obSurepass;
      iconData = obSurepass? Icons.visibility_off :Icons.remove_red_eye;

      emit(LoginIsVisibleEye());

  }
}

