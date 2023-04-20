import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/Home_Layout/home_cupit/home_cubit.dart';
import 'package:shopapp/models/models_response_api/categories_model.dart';
import 'package:shopapp/models/models_response_api/home_model.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/constance/constance.dart';

class ProdectsScreen extends StatelessWidget {
  ProdectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is ChangeFavotiteSuccessState){
          if(!state.model.status!){
            showToast(messege: state.model.message!,
                colorToast: ColorStates.ERROR);
          }
          else {
            showToast(messege: state.model.message!,
                colorToast: ColorStates.SUCCESS);
          }
        };
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).homeModel != null &&
              HomeCubit.get(context).categoriesModel != null,
          builder: (context) => productBuilder(
              HomeCubit.get(context).homeModel!,
              HomeCubit.get(context).categoriesModel!,
              context,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productBuilder(
      HomeModel? homeModel, CategoriesModel? categoriesModel, context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel!.data!.banners!
                .map((e) => Image(
                      fit: BoxFit.cover,
                      width: 1000,
                      height: 100,
                      image: NetworkImage(
                        '${e.image}',
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                height: 250,
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 0.8,
                autoPlayAnimationDuration: Duration(seconds: 1),
                enlargeCenterPage: true),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return buildItemListview(
                            categoriesModel.data!.data![index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel!.data!.data!.length),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New products',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0,
              childAspectRatio: 1 / 1.49,
              crossAxisCount: 2,
              children: List.generate(
                  homeModel.data!.products!.length,
                  (index) =>
                      buildGridProduct(homeModel.data!.products![index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(Products products , context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${products.image}'),
                width: double.infinity,
                height: 150,
                // fit: BoxFit.cover,
              ),
              if (products.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    'Discound',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.white),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  '${products.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14, height: 1, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      '${products.price} ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColore),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    if (products.discount != 0)
                      Text(
                        '${products.oldPrice} ',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          HomeCubit.get(context).changeFavorite(products.id);
                          print(products.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:HomeCubit.get(context).Favorites[products.id]! ? primaryColore : Colors.grey,
                          child: Icon(
                            Icons.favorite_outline,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItemListview(DataModel dataModel) => Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage('${dataModel.image}'),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100,
            child: Text(
              '${dataModel.name}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}
