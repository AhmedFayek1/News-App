import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Home_Cubit/HomeCubit.dart';
import '../Home_Cubit/HomeStates.dart';
import 'package:shop_app/Shared/Style/color/colors.dart';
class SettingsScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print(HomeCubit.get(context).userModel!.data!.name!);
          print(HomeCubit.get(context).userModel!.data!.email!);
          print(HomeCubit.get(context).userModel!.data!.phone!);

          nameController.text = HomeCubit.get(context).userModel!.data!.name!;
          emailController.text = HomeCubit.get(context).userModel!.data!.email!;
          phoneController.text = HomeCubit.get(context).userModel!.data!.phone!;

          return ConditionalBuilder(
              condition: HomeCubit.get(context).userModel != null,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.00),
                child: Form(
                  key: FormKey,
                  child: Column(
                    children: [
                      if(state is ShopUpdateUserLoadingState)
                        LinearProgressIndicator(),
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
                            return 'Name Required';
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
                            return 'Name Required';
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
                      Container(
                        height: 45.00,
                        width: double.infinity,
                        child: MaterialButton(
                          color: defaultcolor,
                          onPressed:() {
                            if(FormKey.currentState!.validate())
                              {
                                HomeCubit.get(context).updateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text
                                );
                              }
                          },
                          child: Text("Update Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.00,color: Colors.white),),
                        ),
                      ),
                      SizedBox(height: 20.00,),
                      Container(
                        height: 45.00,
                        width: double.infinity,
                        child: MaterialButton(
                          color: defaultcolor,
                          onPressed:() {
                            HomeCubit.get(context).signOut(context);
                          },
                          child: Text("Sign Out",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.00,color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator())
          );
        }
    );
  }
}
