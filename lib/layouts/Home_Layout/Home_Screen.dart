import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/Home_Layout/home_cupit/home_cubit.dart';
import 'package:shopapp/models/models_response_api/home_model.dart';
import 'package:shopapp/modules/home_screens/search_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/cloud/dio_helper.dart';

import '../../shared/network/cloud/repositery/home_repository.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cupit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('salla'),
            actions: [
              IconButton(onPressed: () {
                NavigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search),),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Prodects'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
            currentIndex: cupit.currentIndex,
            onTap: (index) {
              cupit.changeBottomNavBar(index);
            },
          ),
          body: cupit.screens[cupit.currentIndex],
        );
      },
    );
  }
}
