import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/models/models_response_api/login_model.dart';
import 'package:shopapp/shared/network/cloud/dio_helper.dart';
import 'package:shopapp/shared/network/cloud/end_points.dart';

part 'registratuon_state.dart';

class RegistratuonCubit extends Cubit<RegistratuonState> {
  RegistratuonCubit() : super(RegistratuonInitial());

  LoginModel? loginModel;

  static RegistratuonCubit? get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    DioHelper.PostData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  IconData iconData = Icons.remove_red_eye;
  bool obSurepass = false;

  void isVisibleeye(){

    obSurepass = !obSurepass;
    iconData = obSurepass? Icons.visibility_off :Icons.remove_red_eye;

    emit(RegisterIsVisibleEye());

  }
}
