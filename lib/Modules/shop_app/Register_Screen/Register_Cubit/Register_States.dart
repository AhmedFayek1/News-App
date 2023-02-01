import '../../../../Models/Shop_Model/shop_model.dart';

abstract class RegisterStates {}

class ShopRegisterInitialState extends RegisterStates {}

class ShopRegisterLoadingState extends RegisterStates {}

class ShopRegisterSuccessState extends RegisterStates {
  final ShopAppModel? loginmodel;

  ShopRegisterSuccessState(this.loginmodel);
}

class ShopRegisterErrorState extends RegisterStates {}

class ShoppRegisterChangeText extends RegisterStates {}
