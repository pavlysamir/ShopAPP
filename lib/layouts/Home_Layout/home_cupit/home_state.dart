part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeChaneNavBar extends HomeState {}

class HomeSuccessState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {}

class CategoriesSuccessState extends HomeState {}

class CategoriesErrorState extends HomeState {}

class ChangeSuccessState extends HomeState {}

class ChangeFavotiteSuccessState extends HomeState {
 final ChangeFavoriteModel model;

  ChangeFavotiteSuccessState(this.model);
}

class ChangeFavotiteErrorState extends HomeState {}

class FavoriteSuccessState extends HomeState {}

class FavoriteErrorState extends HomeState {}
class FavoriteLoadingState extends HomeState {}

class ProfileErrorState extends HomeState {}
class ProfileSuccessState extends HomeState {}
class ProfileLoadingState extends HomeState {}

class UpdateProfileErrorState extends HomeState {
 final String? error;
 UpdateProfileErrorState(this.error);
}
class UpdateProfileSuccessState extends HomeState {
 final LoginModel loginModel;
 UpdateProfileSuccessState(this.loginModel);
}
class UpdateProfileLoadingState extends HomeState {}