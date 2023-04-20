part of 'registratuon_cubit.dart';

@immutable
abstract class RegistratuonState {}

class RegistratuonInitial extends RegistratuonState {}
class RegisterLoadingState extends RegistratuonState{}

class RegisterSuccessState extends RegistratuonState{
  final LoginModel model;

  RegisterSuccessState(this.model);
}
class RegisterErrorState extends RegistratuonState {
  final String? error;

  RegisterErrorState(this.error);
}
class RegisterIsVisibleEye extends RegistratuonState{}