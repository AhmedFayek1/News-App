import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/Shop_Model/shop_model.dart';
import 'package:shop_app/Modules/shop_app/Login/LoginCubit/LoginStates.dart';
import 'package:shop_app/Modules/shop_app/Register_Screen/Register_Cubit/Register_States.dart';
import 'package:shop_app/Shared/Network/end_points.dart';
import 'package:shop_app/Shared/Network/remote/Dio_Helber.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(ShopRegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  ShopAppModel? shopappmodel;


  void userRegister({required String name,required String email,required String phone, required String password}) {
    emit(ShopRegisterLoadingState());
    dio_helper.postData(
        url: REGISTER,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        }
    ).then((value) {
      print(value);
      shopappmodel = ShopAppModel.fromjson(value.data);

      emit(ShopRegisterSuccessState(shopappmodel));
    }).catchError((onError) {
      print(onError);
      emit(ShopRegisterErrorState());
    });
  }

  IconData icon = Icons.remove_red_eye_outlined;
  bool IsShown = true;

  void changeText() {
    IsShown = ! IsShown;
    IsShown ? icon = Icons.remove_red_eye_outlined : icon = Icons.remove_red_eye;
    emit(ShoppRegisterChangeText());
  }
}
