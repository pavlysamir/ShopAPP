

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/shared/constance/constance.dart';

import '../../layouts/Home_Layout/home_cupit/home_cubit.dart';
import '../../models/models_response_api/favorite_model.dart';


void NavigateTo(context , Widget){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=> Widget),
  );
}

void NavigateAndFinish(context , Widget){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context)=> Widget),
      (route) => false);
}

void showToast(
    {required String messege,
     required ColorStates colorToast,
    }
    ){
  Fluttertoast.showToast(
      msg: messege,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: shooseCloreToast(colorToast),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ColorStates{SUCCESS,ERROR,WARNING}

Color shooseCloreToast(ColorStates state)
{
  Color color;
  if(state == ColorStates.SUCCESS){
     color = Colors.green.withOpacity(0.8);
  }else  if(state == ColorStates.ERROR){
     color = Colors.red;
  }else  color = Colors.amber;

  return color;
}

Widget buildItemforListview( model, context,{ bool? oldPrice = true}){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      // width: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model!.image}'),
                width:120,
                height: 120,
              ),
              if (model!.discount != 0 && oldPrice!)
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    '${model!.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14, height: 1, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model!.price} ',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColore),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      if (model!.image != 0 && oldPrice!)
                        Text(
                          '${model!.oldPrice} ',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          HomeCubit.get(context).changeFavorite(model.id);
                          //print(products.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:HomeCubit.get(context).Favorites[model.id]! ? primaryColore : Colors.grey,
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
          ),
        ],
      ),
    ),
  );
}