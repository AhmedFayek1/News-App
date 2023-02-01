import 'package:shop_app/Models/Favourites_Model/Favourites_Model.dart';
import 'package:shop_app/Models/Home_Model/HomeModel.dart';

abstract class HomeStates {}

class HomePageInitialState extends HomeStates {}

class HomePageChangeNavBarState extends HomeStates {}

class ShopLoadingHomeDataState extends HomeStates {}

class ShopSuccessHomeDataState extends HomeStates {
  final HomeModel homeModel;

  ShopSuccessHomeDataState(this.homeModel);
}

class ShopErrorHomeDataState extends HomeStates {}


class ShopGetCategoriesSuccessState extends HomeStates {}

class ShopGetCategoriesErrorState extends HomeStates {}

class ShopChangeFavouritesSuccessState extends HomeStates {
  final FavouritesModel model;

  ShopChangeFavouritesSuccessState(this.model);
}

class ShopChangeFavouritesErrorState extends HomeStates {}

class ShopChangeFavouritesState extends HomeStates {}

class ShopGetFavouritesLoadingState extends HomeStates {}

class ShopGetFavouritesSuccessState extends HomeStates {}

class ShopGetFavouritesErrorState extends HomeStates {}

class ShopGetUserSuccessState extends HomeStates {}

class ShopGetUserErrorState extends HomeStates {}

class ShopUpdateUserLoadingState extends HomeStates {}

class ShopUpdateUserSuccessState extends HomeStates {}

class ShopUpdateUserErrorState extends HomeStates {}




