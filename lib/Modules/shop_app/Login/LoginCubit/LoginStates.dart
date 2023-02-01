
import 'package:shop_app/Models/Shop_Model/shop_model.dart';


abstract class ShopStates {}

class ShopAppLoadingState extends ShopStates {}

class ShopAppSuccessState extends ShopStates {
  final ShopAppModel loginmodel;

  ShopAppSuccessState(this.loginmodel);
}

class ShopAppErrorState extends ShopStates {
  final error;
  ShopAppErrorState(this.error);
}

class ShoppAppChangeText extends ShopStates {}