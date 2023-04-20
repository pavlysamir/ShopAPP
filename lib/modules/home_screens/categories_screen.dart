import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/Home_Layout/home_cupit/home_cubit.dart';
import 'package:shopapp/models/models_response_api/categories_model.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return ListView.separated(
        itemBuilder: (context , index) => builditemBuilder(HomeCubit.get(context).categoriesModel!.data!.data![index]),
        separatorBuilder: (context , index) => Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Container(
            color: Colors.grey,
            height: 1,
          ),
        ),
        itemCount: HomeCubit.get(context).categoriesModel!.data!.data!.length);
  },
);
  }

  Widget builditemBuilder(DataModel model) => Padding(
    padding: const EdgeInsets.all(18.0),
    child: Row(
      children: [
        Image(image: NetworkImage('${model.image}'),
          height: 100,
          width: 100,
        ),
        SizedBox(
          width: 30,
        ),
        Text('${model.name}' ,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
            overflow: TextOverflow.ellipsis,
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
