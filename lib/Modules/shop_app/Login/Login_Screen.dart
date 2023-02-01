import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Layout/shop_layout/Shop_Layout.dart';
import 'package:shop_app/Modules/shop_app/Login/LoginCubit/LoginCubit.dart';
import 'package:shop_app/Modules/shop_app/Login/LoginCubit/LoginStates.dart';
import 'package:shop_app/Modules/shop_app/Register_Screen/Register_Screen.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/Constants/constants.dart';
import 'package:shop_app/Shared/Network/local/Cache_Helper.dart';

class login_screen extends StatelessWidget {
  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state) {
          if(state is ShopAppSuccessState)
            {
              if(state.loginmodel.status!)
                {
                    print(state.loginmodel.message);
                    print(state.loginmodel.data!.token);
                    ShowToast(message: state.loginmodel.message!, state: ToastStates.SUCCESS);
                    cache_helper.SaveData(key: 'token', value: state.loginmodel.data!.token).then((value) {
                      token = state.loginmodel.data!.token!;
                      NavigatetoFinish(context, ShopAppLayout());
                    });
                }
              else
                {
                  print(state.loginmodel.message);
                  ShowToast(message: state.loginmodel.message!, state: ToastStates.ERROR);
                }
            }
        },
        builder:  (context,state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: FormKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.00),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Login",style: Theme.of(context).textTheme.headline5,),
                      SizedBox(height: 20.00,),
                      Text("Login to browse hot Offers",style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),),
                      SizedBox(height: 30.00,),
                      TextFormField(
                        controller: EmailController,
                        validator: (value) {
                          if(value!.isEmpty)
                          {
                            return 'Email Required';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        onTap: () {},
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 30.00,),
                      TextFormField(
                        controller: PasswordController,
                        validator: (value) {
                          if(value!.isEmpty)
                          {
                            return 'Password Required';
                          }
                          return null;
                        },
                        obscureText: ShopCubit.get(context).IsShown,
                        onChanged: (value) {
                        },
                        onFieldSubmitted: (value)
                        {
                          if(FormKey.currentState!.validate())
                            print(EmailController.text);
                            print(PasswordController.text);

                          ShopCubit.get(context).User_Login(email: EmailController.text, password: PasswordController.text);
                        },
                        onTap: () {},
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                ShopCubit.get(context).ChangeText();
                              },
                              icon: Icon(ShopCubit.get(context).icon,),),
                        ),

                      ),
                      SizedBox(height: 30.00,),
                      ConditionalBuilder(
                          condition: state != ShopAppLoadingState,
                          builder: (context) => Container(
                            height: 50.00,
                            width: double.infinity,
                            color: Colors.blue,

                            child: MaterialButton(
                              onPressed: ()
                              {
                                if(FormKey.currentState!.validate()) {
                                print(EmailController.text);
                                print(PasswordController.text);

                                ShopCubit.get(context).User_Login(
                                    email: EmailController.text,
                                    password: PasswordController.text);
                              }
                            },
                              child: Text("LOGIN"),
                            ),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(height: 30.00,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Don't have account?"),
                          SizedBox(width: 20.00,),
                          TextButton(
                              onPressed: () {
                                Navigateto(context, Register_Screen());
                              },
                              child: Text("REGISTER")
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}


