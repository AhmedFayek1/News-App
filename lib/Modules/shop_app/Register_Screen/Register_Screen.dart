import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/shop_app/Register_Screen/Register_Cubit/Register_Cubit.dart';
import 'package:shop_app/Modules/shop_app/Register_Screen/Register_Cubit/Register_States.dart';
import 'package:shop_app/Shared/Network/local/Cache_Helper.dart';

import '../../../Layout/shop_layout/Shop_Layout.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/Constants/constants.dart';
import '../../../Shared/Style/color/colors.dart';

class Register_Screen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
    child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginmodel!.status!)
            {
              print(state.loginmodel!.message);
              print(state.loginmodel!.data!.token);
              ShowToast(message: state.loginmodel!.message!, state: ToastStates.SUCCESS);
              token = state.loginmodel!.data!.token!;
              cache_helper.SaveData(key: 'token', value: state.loginmodel!.data!.token).then((value) {
                NavigatetoFinish(context, ShopAppLayout());
              });
            }
            else
            {
              print(state.loginmodel!.message);
              ShowToast(message: state.loginmodel!.message!, state: ToastStates.ERROR);

            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.00),
                  child: Form(
                    key: FormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Register",style: Theme.of(context).textTheme.headline5,),
                        SizedBox(height: 20.00,),
                        Text("Register to browse hot Offers",style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),),
                        SizedBox(height: 20.00,),
                        TextFormField(
                          controller: nameController,
                          validator: (value)
                          {
                            if(value!.isEmpty) {
                              return 'Name Required';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(0.0),
                              ),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.00,),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email Required';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(0.0),
                              ),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.00,),
                        TextFormField(
                          controller: phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone Required';
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'Phone Number',
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(0.0),
                              ),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.00,),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password Required';
                            }
                          },
                          obscureText: RegisterCubit.get(context).IsShown,

                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {RegisterCubit.get(context).changeText();},
                              icon: Icon(RegisterCubit.get(context).icon),
                            ),
                            labelText: 'Password',
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(0.0),
                              ),
                              borderSide: new BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.00,),
                    ConditionalBuilder(
                      condition: state != ShopRegisterLoadingState,
                      builder: (context) => Container(
                        height: 45.00,
                        width: double.infinity,
                        child: MaterialButton(
                          color: defaultcolor,
                          onPressed:() {
                            if(FormKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          child: Text("REGISTER",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.00,color: Colors.white),),
                        ),
                      ),
                      fallback: (context) => Center(child: CircularProgressIndicator()),
                    )]
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    )
    );
  }
}
