import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/Shop_Model/shop_model.dart';
import 'package:shop_app/Modules/shop_app/Login/LoginCubit/LoginStates.dart';
import 'package:shop_app/Shared/Network/end_points.dart';
import 'package:shop_app/Shared/Network/remote/Dio_Helber.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopAppLoadingState());

  static ShopCubit get(context) => BlocProvider.of(context);

  ShopAppModel? shopappmodel;


  void User_Login({required String email, required String password}) {
    emit(ShopAppLoadingState());
    dio_helper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password': password,
        }
    ).then((value) {
      print(value.data);
      shopappmodel = ShopAppModel.fromjson(value.data);
      emit(ShopAppSuccessState(shopappmodel!));
    }).catchError((onError) {
      print(onError);
      emit(ShopAppErrorState(onError));
    });
  }

  IconData icon = Icons.remove_red_eye_outlined;
  bool IsShown = true;

  void ChangeText() {
    IsShown = ! IsShown;
    IsShown ? icon = Icons.remove_red_eye_outlined : icon = Icons.remove_red_eye;
    emit(ShoppAppChangeText());
  }
}
