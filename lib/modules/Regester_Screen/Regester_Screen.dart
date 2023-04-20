import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/Home_Layout/Home_Screen.dart';
import 'package:shopapp/modules/login_Screen/Login_Screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/constance/constance.dart';
import 'package:shopapp/shared/cupit/login_cupit/login_cubit.dart';
import 'package:shopapp/shared/cupit/login_cupit/login_state.dart';
import 'package:shopapp/shared/cupit/register_cupit/registratuon_cubit.dart';
import 'package:shopapp/shared/network/local/cashe_helper.dart';

class RegesterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistratuonCubit(),
      child: BlocConsumer<RegistratuonCubit, RegistratuonState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.model.status == true) {
              showToast(
                messege: '${state.model.message}',
                colorToast: ColorStates.SUCCESS,
              );
              CasheHelper.SaveData(
                  key: 'token', value: state.model.data!.token)
                  .then((value) {
                token = state.model.data!.token;
                NavigateAndFinish(context, LoginScreen());
              });
            } else {
              showToast(
                messege: '${state.model.message}',
                colorToast: ColorStates.ERROR,
              );
            }
           }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'REGISTER',
                          style: TextStyle(fontSize: 35),
                        ),
                        const Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: nameController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('User Name'),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Email Address'),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: RegistratuonCubit.get(context)!.obSurepass,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password is to short';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Password'),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  RegistratuonCubit.get(context)!.isVisibleeye();
                                },
                                icon: Icon(
                                  RegistratuonCubit.get(context)!.iconData,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: phoneController,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              RegistratuonCubit.get(context)!.userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          keyboardType: TextInputType.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your phone';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Phonw'),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: State is! RegisterLoadingState,
                          builder: (context) =>
                              Container(
                                  width: double.infinity,
                                  height: 55,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          RegistratuonCubit.get(context)!.userRegister(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phone: phoneController.text,
                                          );
                                        }
                                      },
                                      child: const Text('REGISTER'))),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
