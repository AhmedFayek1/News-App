import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/Search_Model/Search_Model.dart';
import 'package:shop_app/Modules/shop_app/Search/Search_Cubit/Search_Cubit.dart';
import 'package:shop_app/Modules/shop_app/Search/Search_Cubit/Search_States.dart';

import '../../../Shared/Components/components.dart';
import '../../../Shared/Style/color/colors.dart';
import '../Home_Cubit/HomeCubit.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state) {},
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.00),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      validator: (value)
                      {
                        if(value!.isEmpty) {
                          return 'Enter Product Name';
                        }
                      },
                      onFieldSubmitted: (String value)
                      {
                        SearchCubit.get(context).search(text: value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(0.0),
                          ),
                          borderSide: new BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.00,),
                    if(state is ShopSearchSuccessState)
                      Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index) =>
                              buildItem(SearchCubit.get(context).searchModel!.data!.data![index]!,context),
                          separatorBuilder: (context, index) =>
                              Container(
                                width: double.infinity,
                                height: 1.00,
                                color: Colors.grey[300],
                              ),
                          itemCount: SearchCubit.get(context).searchModel!.data!.data!.length
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }


}
