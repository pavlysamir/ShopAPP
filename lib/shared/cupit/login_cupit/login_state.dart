
import 'package:shopapp/models/models_response_api/login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState{
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginState
{
  final String? error;

  LoginErrorState(this.error);
}
class LoginIsVisibleEye extends LoginState{}


