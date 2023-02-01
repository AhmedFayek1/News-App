import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/Layout/shop_layout/Shop_Layout.dart';
import 'package:shop_app/Modules/shop_app/Favourites/FavouritesScreen.dart';
import 'package:shop_app/Modules/shop_app/Home_Cubit/HomeCubit.dart';
import 'package:shop_app/Modules/shop_app/Login/Login_Screen.dart';

import 'Modules/shop_app/on_boarding/On_Boarding.dart';
import 'Shared/Bloc_Observer.dart';
import 'Shared/Constants/constants.dart';
import 'Shared/Cubit/cubit.dart';
import 'Shared/Cubit/states.dart';
import 'Shared/Style/themes.dart';
import 'package:shop_app/Shared/Network/remote/Dio_Helber.dart';
import 'package:shop_app/Shared/Network/local/Cache_Helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  dio_helper.init();
  await cache_helper.init();

  bool IsDark = cache_helper.GetData(key: 'IsDark');
  bool OnBoarding = cache_helper.GetData(key: 'OnBoarding');
  token = cache_helper.GetData(key: 'token');
  print(token);
  Widget widget;
    if(OnBoarding != null)
      {
        if(token != null) widget = ShopAppLayout();
        else widget = login_screen();
      }
    else widget = OnBoardingScreen();
  runApp(MyApp(
    IsDark: IsDark,
    startwidget : widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool IsDark;
  //final bool OnBoarding;
  final Widget startwidget;

  MyApp({required this.IsDark,required this.startwidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..ChangeMode(fromshared: IsDark)), 
        BlocProvider(create: (BuildContext context) => HomeCubit()..GetHomeData()..GetCategoriesData()..getFavouriteProducts()..getUserData())
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {},
        builder: (context,state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LighteMode,
            darkTheme: DarkMode,
            // themeMode: AppCubit.get(context).IsDark ? ThemeMode.dark :  ThemeMode.light,
            themeMode: ThemeMode.light,

            home: startwidget,
            //home: ShopAppLayout(),
          );
        },
      ),
    );
  }
}

