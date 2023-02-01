import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/Categories_Model/Categories_Model.dart';
import 'package:shop_app/Models/Favourites/Favourites.dart';
import 'package:shop_app/Models/Favourites_Model/Favourites_Model.dart';
import 'package:shop_app/Models/Home_Model/HomeModel.dart';
import 'package:shop_app/Models/Shop_Model/shop_model.dart';
import 'package:shop_app/Modules/shop_app/Categories/CategoriesScreen.dart';
import 'package:shop_app/Modules/shop_app/Favourites/FavouritesScreen.dart';
import 'package:shop_app/Modules/shop_app/Home_Cubit/HomeStates.dart';
import 'package:shop_app/Modules/shop_app/Products/ProductsScreen.dart';
import 'package:shop_app/Modules/shop_app/Settings/SettingsScreen.dart';
import 'package:shop_app/Shared/Network/end_points.dart';
import 'package:shop_app/Shared/Network/local/Cache_Helper.dart';
import 'package:shop_app/Shared/Network/remote/Dio_Helber.dart';
import 'package:shop_app/main.dart';
import '../../../Shared/Components/components.dart';
import '../../../Shared/Constants/constants.dart';
import '../Login/Login_Screen.dart';

class HomeCubit extends Cubit<HomeStates>
{
  HomeCubit() : super(HomePageInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> Screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  int currentindex = 0;

  void ChangeNavBar(index)
  {
    currentindex = index;
    if(index == 2) getFavouriteProducts();
    emit(HomePageChangeNavBarState());
  }

  HomeModel? homemodel;

  Map<int,bool>? favourites = {};

  void GetHomeData()
  {
    emit(ShopLoadingHomeDataState());
    dio_helper.getData(url: HOME,token: token).then((value) {
      homemodel = HomeModel.fromjson(value.data);
      print(homemodel!.status);
      homemodel!.data!.products!.forEach((element) {
        //element.in_favorites = true;
        print("${element.id}  ${element.in_favorites}");
       favourites?.addAll({
          element.id!: element.in_favorites!
        });
      });
      print("Favourites " + favourites.toString());
      emit(ShopSuccessHomeDataState(homemodel!));
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopErrorHomeDataState());
    });
  }



  CategoriesModel? categoriesModel;

  void GetCategoriesData()
  {
    dio_helper.getData(url: Get_Categories).
    then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);

      emit(ShopGetCategoriesSuccessState());
    }).catchError((onError)
    {
      print("lala");
      print(onError.toString());
      emit(ShopGetCategoriesErrorState());
    });
  }


  void signOut(context)
  {
    cache_helper.RemoveData(key: 'token').then((value) {
      if(value)
        {
          NavigatetoFinish(context,login_screen());
        }
    });
  }

  FavouritesModel? favouritesModel;


  void changeFavourites(int id)
  {
    favourites![id] = !favourites![id]!;
    emit(ShopChangeFavouritesState());

    dio_helper.postData(
        url: FAVOURITES,
        data: {
          'product_id': id,
        },
        token: token
    ).then((value) {
        favouritesModel = FavouritesModel.fromjson(value.data);
        print(value.data);
        if(!favouritesModel!.status!) favourites![id] = !favourites![id]!;
        else getFavouriteProducts();
        emit(ShopChangeFavouritesSuccessState(favouritesModel!));
    }).catchError((onError) {
        favourites![id] = !favourites![id]!;
        emit(ShopChangeFavouritesErrorState());
    });
  }


  FavouritesProducts? favouriteProducts;

  void getFavouriteProducts()
  {
    emit(ShopGetFavouritesLoadingState());
    dio_helper.getData(url: FAVOURITES,token: token).
    then((value) {
      favouriteProducts = FavouritesProducts.fromJson(value.data);

      emit(ShopGetFavouritesSuccessState());
    }).catchError((onError)
    {
      print("lala");
      print(onError.toString());
      emit(ShopGetFavouritesErrorState());
    });
  }


  ShopAppModel? userModel;

  void getUserData()
  {
    dio_helper.getData(url: PROFILE,token: token).
    then((value) {
      userModel = ShopAppModel.fromjson(value.data);
      emit(ShopGetUserSuccessState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopGetUserErrorState());
    });
  }

  void updateUserData({
      required String name,
      required String email,
      required String phone
  })
  {
    emit(ShopUpdateUserLoadingState());
    dio_helper.putData(
        url: UPDATE,
        data: {
          'name': name,
          'email': email,
          'phone': phone
        },
        token: token).
    then((value) {
      userModel = ShopAppModel.fromjson(value.data);
      emit(ShopUpdateUserSuccessState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopUpdateUserErrorState());
    });
  }

}