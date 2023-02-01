import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/Categories_Model/Categories_Model.dart';
import 'package:shop_app/Modules/shop_app/Home_Cubit/HomeCubit.dart';

import '../Home_Cubit/HomeStates.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state) {},
        builder: (context,state) {
            return ListView.separated(
                itemBuilder: (context,index) => buildCategoriesItem(HomeCubit.get(context).categoriesModel!.data!.data[index]!),
                separatorBuilder: (context,index) => Container(
                  width: double.infinity,
                  height: 1.00,
                  color: Colors.grey[300],
                ),
                itemCount: HomeCubit.get(context).categoriesModel!.data!.data.length
            );
        }
    );
  }

  Widget buildCategoriesItem(PageData model) => Padding(
    padding: const EdgeInsets.all(20.00),
    child: Row(
      children: [
        Image(image: NetworkImage(model.image!),
          fit: BoxFit.cover,
          height: 120.00,
          width: 120.00,
        ),
        SizedBox(width: 10.00,),
        Text(model.name!,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
      ],
    ),
  );
}
