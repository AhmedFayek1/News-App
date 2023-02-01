import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/Home_Model/HomeModel.dart';
import 'package:shop_app/Modules/shop_app/Home_Cubit/HomeCubit.dart';
import 'package:shop_app/Modules/shop_app/Home_Cubit/HomeStates.dart';
import 'package:shop_app/Modules/shop_app/Login/Login_Screen.dart';
import 'package:shop_app/Modules/shop_app/Search/SearchScreen.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/Network/local/Cache_Helper.dart';

class ShopAppLayout extends StatelessWidget {
  const ShopAppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Salla", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigateto(context, SearchScreen());
                    },
                    icon: Icon(Icons.search),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentindex,
                onTap: (int)
                {
                  cubit.ChangeNavBar(int);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps),
                      label: 'Categories'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: 'favorite'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'settings'
                  ),
                ]
            ),
            body: cubit.Screens[cubit.currentindex],

          );
        }
    );
  }

}
