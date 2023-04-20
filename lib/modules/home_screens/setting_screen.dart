import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/Home_Layout/home_cupit/home_cubit.dart';
import 'package:shopapp/shared/constance/constance.dart';
class SettingScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    return BlocConsumer<HomeCubit , HomeState>(
        listener: (context , state){},
        builder: (context , state){
          var model = HomeCubit.get(context).loginModel!.data!;
          emailController.text = model.email!;
          phoneController.text = model.phone!;
          nameController.text = model.name!;
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if(state is UpdateProfileLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      validator: (String? value){
                        if(value!.isEmpty){
                          return 'please full your name';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                      ),


                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: emailController,
                      validator: (String? value){
                        if(value!.isEmpty){
                          return 'please full your email';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),


                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: phoneController,
                      validator: (String? value){
                        if(value!.isEmpty){
                          return 'please full your phone';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                      ),


                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ConditionalBuilder(
                      condition: state is! UpdateProfileLoadingState,
                      builder: (context)=> Container(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(onPressed: (){
                          if(formKey.currentState!.validate()){
                            HomeCubit.get(context).userUpdate(
                              token: token.toString(),
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        },
                          child: Text('UPDATE',
                            style: TextStyle(
                              fontSize: 18,
                            ),),
                        ),
                      ),
                      fallback: (context)=>Center(child: CircularProgressIndicator(),),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(onPressed: (){
                        Logout(context);
                      },
                        child: Text('LOGOUT',
                          style: TextStyle(
                            fontSize: 18,
                          ),),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
    },
       );
  }


}


