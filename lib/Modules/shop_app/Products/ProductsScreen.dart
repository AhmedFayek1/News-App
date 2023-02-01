
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/Categories_Model/Categories_Model.dart';
import 'package:shop_app/Modules/shop_app/Home_Cubit/HomeCubit.dart';
import 'package:shop_app/Modules/shop_app/Home_Cubit/HomeStates.dart';
import 'package:shop_app/Modules/shop_app/Login/LoginCubit/LoginCubit.dart';
import 'package:shop_app/Modules/shop_app/Login/LoginCubit/LoginStates.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/Style/color/colors.dart';

import '../../../Models/Home_Model/HomeModel.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state) {
          if(state is ShopChangeFavouritesSuccessState)
            {
              if(!state.model.status!)
                {
                  ShowToast(message: state.model.message!, state: ToastStates.ERROR);
                }
            }
        },
        builder: (context,state) {
          return  ConditionalBuilder(
            condition: HomeCubit.get(context).homemodel != null && HomeCubit.get(context).categoriesModel != null,
            builder: (context) => ProductBuilder(HomeCubit.get(context).homemodel!,HomeCubit.get(context).categoriesModel,context),
            fallback:(context) => Center(child: CircularProgressIndicator()),
          );
        },
);


  }

  Widget ProductBuilder(HomeModel model, CategoriesModel? categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model.data!.banners!.map((e) =>
                Image(
                  image: NetworkImage(e.image!),
                  width: double.infinity,
                  fit: BoxFit.cover,
                )).toList(),
            options: CarouselOptions(
              height: 250.00,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1.00,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            )
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.00
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
              SizedBox(height: 15,),
              Container(
                height: 100.00,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) => buildCategoriesItem(categoriesModel!.data!.data[index]),
                    separatorBuilder: (context,index) => SizedBox(width: 10.00,),
                    itemCount: categoriesModel!.data!.data.length
                ),
              ),
              SizedBox(height: 15,),
              Text("New Products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
            ],
          ),
        ),
        SizedBox(height: 15.00,),
        Container(
          color: Colors.grey,
          child: GridView.count(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1.00,
              crossAxisSpacing: 1.00,
              childAspectRatio: 1 / 1.55,
              crossAxisCount: 2,
            children: List.generate(model.data!.products!.length, (index) =>buildProductItem(model.data!.products![index],context) ),
          ),
        )
      ],
    ),
  );

  Widget buildCategoriesItem(PageData categori) => Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image(
        image: NetworkImage(categori.image!),
        height: 100.00,
        width: 100.00,
      ),
      Container(
          width: 100,
          color: Colors.black.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(categori.name!,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,maxLines: 1,),
          )),
    ],
  );


  Widget buildProductItem(ProductModel model,context) => Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image!),
            width: double.infinity,
              height: 200,
            ),
            if(model.discount != 0)
              Container(
              color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Discount",style: TextStyle(color: Colors.white),),
                )
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.00),
          child: Column(
            children: [
              Text(model.name!,style: TextStyle(fontSize: 14.00,height: 1.3,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
              Row(
                children: [
                  Text("${model.price.round()}",style: TextStyle(fontSize: 14.00,color: defaultcolor),),
                  SizedBox(width: 5.00,),
                  if(model.discount != 0)
                    Text("${model.old_price.round()}",style: TextStyle(fontSize: 12.00,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                  Spacer(),
                  IconButton(onPressed: () {HomeCubit.get(context).changeFavourites(model.id!);}, icon: CircleAvatar(child: Icon(Icons.favorite_border,size: 14.00,color: Colors.white,),backgroundColor: HomeCubit.get(context).favourites![model.id]!? defaultcolor :  Colors.grey ,radius: 15.00,),padding: EdgeInsets.all(0),)
                ],
              ),
            ],
          ),
        ),

      ],
    ),
  );

}
