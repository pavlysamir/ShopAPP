import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/models/models_response_api/shearch_model.dart';
import 'package:shopapp/shared/constance/constance.dart';
import 'package:shopapp/shared/network/cloud/dio_helper.dart';
import 'package:shopapp/shared/network/cloud/end_points.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void SearchData(String text , String token){
    emit(SearchLoadingState());
    DioHelper.PostData(url: SEARCH,
        data: {
            'text' : text
        },
      token: token,
    ).then((value) {
          searchModel = SearchModel.fromJson(value.data);
          emit(SearchSuccessState());
          print(value.data.toString());
    }).catchError((error){
      emit(SearchErrorState());
      print(error.toString());
    });

  }


}
