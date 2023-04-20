
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/models/models_response_api/categories_model.dart';
import 'package:shopapp/models/models_response_api/change_favorite_model.dart';
import 'package:shopapp/models/models_response_api/favorite_model.dart';
import 'package:shopapp/models/models_response_api/home_model.dart';
import 'package:shopapp/models/models_response_api/login_model.dart';
import 'package:shopapp/modules/home_screens/categories_screen.dart';
import 'package:shopapp/modules/home_screens/favorite_screen.dart';
import 'package:shopapp/modules/home_screens/prodect_screen.dart';
import 'package:shopapp/modules/home_screens/setting_screen.dart';
import 'package:shopapp/shared/constance/constance.dart';
import 'package:shopapp/shared/network/cloud/dio_helper.dart';
import 'package:shopapp/shared/network/cloud/end_points.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    ProdectsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;

    emit(HomeChaneNavBar());
  }

  HomeModel? homeModel;
  Map<int, bool> Favorites={};

  void getDataHome() {
    print('hello');
    emit(HomeLoadingState());
    DioHelper.getData(url: HOME, token: token!,).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products!.forEach((element) {
        Favorites.addAll({
          element.id! : element.inFavorites!,
        });
      });
      print(Favorites.toString());

      emit(HomeSuccessState());

    }).catchError((e) {
      print('error : ' + e.toString());
      emit(HomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;
  void getDataCategory() {
    DioHelper.getData(url: GET_CATEGORIES, token: token!).then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);
      emit(CategoriesSuccessState());
    }).catchError((error) {
      emit(CategoriesErrorState());
    });
  }


  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorite(int? productId) {
    Favorites[productId!] = !Favorites[productId]!;
    emit(ChangeSuccessState());

    DioHelper.PostData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromjson(value.data);
      print(value.data);
      if(!changeFavoriteModel!.status!){
        Favorites[productId!] = !Favorites[productId]!;
      }else{getDataFavorite();}
      emit(ChangeFavotiteSuccessState(changeFavoriteModel!));
    }).catchError((error) {
      Favorites[productId!] = !Favorites[productId]!;

      emit(ChangeFavotiteErrorState());
    });
  }

  FavoriteModel? favoriteModel;
  void getDataFavorite(){
    DioHelper.getData(
        url: FAVORITES,
        token: token!,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(FavoriteSuccessState());
    }).catchError((error){
      emit(FavoriteErrorState());
    });
  }

  LoginModel? loginModel;
  void getDataProfile(){
    emit(ProfileLoadingState());

    DioHelper.getData(
      url: PROFILE,
      token: token!,
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.data!.name);
      emit(ProfileSuccessState());
    }).catchError((error){
      emit(ProfileErrorState());
    });
  }

  void userUpdate({
    required String name,
    required String email,
    required String phone,
    required String token
  }) {
    emit(UpdateProfileLoadingState());

    DioHelper.PutData(url:UPDATE_PROFILE, data: {
    'name': name,
    'email': email,
    'phone': phone,
    },
    token: token,
    ).then((value) {
    loginModel = LoginModel.fromJson(value.data);
    emit(UpdateProfileSuccessState(loginModel!));
    }).catchError((error) {
    emit(UpdateProfileErrorState(error));
    });
  }
}
