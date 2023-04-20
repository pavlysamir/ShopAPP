import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/Home_Layout/home_cupit/home_cubit.dart';
import 'package:shopapp/models/models_response_api/favorite_model.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/constance/constance.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! FavoriteLoadingState,
          builder: (context) =>ListView.separated(
              itemBuilder: (context , index) => buildItemforListview(HomeCubit.get(context).favoriteModel!.data!.data![index].product,context),
              separatorBuilder: (context , index) => Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Container(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
              itemCount: HomeCubit.get(context).favoriteModel!.data!.data!.length),
          fallback:(context)=> Center(child: CircularProgressIndicator(),) ,
        );
      },
    );
  }


}
