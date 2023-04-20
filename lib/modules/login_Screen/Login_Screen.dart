import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layouts/Home_Layout/Home_Screen.dart';
import 'package:shopapp/modules/Regester_Screen/Regester_Screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/constance/constance.dart';
import 'package:shopapp/shared/cupit/login_cupit/login_cubit.dart';
import 'package:shopapp/shared/cupit/login_cupit/login_state.dart';
import 'package:shopapp/shared/network/local/cashe_helper.dart';

class LoginScreen extends StatelessWidget {
  bool isVisible = false;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status == true) {
              showToast(
                messege: '${state.loginModel.message}',
                colorToast: ColorStates.SUCCESS,
              );
              CasheHelper.SaveData(
                  key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                NavigateAndFinish(context, HomeLayout());
              });
            } else {
              showToast(
                messege: '${state.loginModel.message}',
                colorToast: ColorStates.ERROR,
              );
            }
          }
        },
        builder: (context, State) {
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
                            'LOGIN',
                            style: TextStyle(fontSize: 35),
                          ),
                          const Text(
                            'login now to browse our hot offers',
                            style: TextStyle(fontSize: 20, color: Colors.grey),
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
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context)!.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: LoginCubit.get(context)!.obSurepass,
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
                                    LoginCubit.get(context)!.isVisibleeye();
                                  },
                                  icon: Icon(
                                    LoginCubit.get(context)!.iconData,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: State is! LoginLoadingState,
                            builder: (context) =>
                                Container(
                                    width: double.infinity,
                                    height: 55,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            LoginCubit.get(context)!.userLogin(
                                                email: emailController.text,
                                                password: passwordController
                                                    .text);
                                          }
                                        },
                                        child: const Text('LOGIN'))),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: TextStyle(fontSize: 20),
                              ),
                              TextButton(
                                  onPressed: () {
                                    NavigateTo(context, RegesterScreen());
                                  },
                                  child: Text(
                                    'REGISTER',
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
