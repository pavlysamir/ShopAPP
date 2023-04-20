// import 'package:dio/dio.dart';
// import 'package:shopapp/models/models_response_api/home_model.dart';
// import 'package:shopapp/shared/network/cloud/dio_helper.dart';
// import 'package:shopapp/shared/network/cloud/end_points.dart';
//
// class HomeRepository{
//   final DioHelper dioHelper;
//   HomeRepository(this.dioHelper);
//
//   Future<List<HomeModel>> getAllData() async{
//     final homemodel= await dioHelper.getData(url: HOME);
//     return homemodel.map((element) => HomeModel.fromJson(element)).toList();
//
//   }
// }