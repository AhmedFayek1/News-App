import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/Favourites/Favourites.dart';
import 'package:shop_app/Modules/shop_app/Home_Cubit/HomeCubit.dart';
import 'package:shop_app/Modules/shop_app/Home_Cubit/HomeStates.dart';

import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/color/colors.dart';

class FavouritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is! ShopGetFavouritesLoadingState,
              builder: (context) =>
                  ListView.separated(
                      itemBuilder: (context,index) =>
                          buildItem(HomeCubit.get(context).favouriteProducts!.data!.data![index]!.product,context),
                      separatorBuilder: (context, index) =>
                          Container(
                            width: double.infinity,
                            height: 1.00,
                            color: Colors.grey[300],
                          ),
                      itemCount: HomeCubit.get(context).favouriteProducts!.data!.data!.length
                  ),
              fallback: (context) => Center(child: CircularProgressIndicator())
          );
        }
    );

  }

}