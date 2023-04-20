import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/home_screens/search_cupit/search_cubit.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/constance/constance.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text('Search'),),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    TextFormField(
                      controller: searchController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please Search';
                        }
                      },
                      onChanged: (value) {
                        SearchCubit.get(context)
                            .SearchData(value, token!);
                      },
                      onFieldSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context)
                              .SearchData(value, token!);
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Search'),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildItemforListview(
                                SearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data![index],
                                context,
                                oldPrice: false),
                            separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Container(
                                    color: Colors.grey,
                                    height: 1,
                                  ),
                                ),
                            itemCount: SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data!
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
