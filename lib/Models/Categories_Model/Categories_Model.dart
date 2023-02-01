import 'package:flutter/foundation.dart';

class CategoriesModel {
  bool? status;
  CategoriesModelData? data;

  CategoriesModel.fromjson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = json['data']!= null ?  CategoriesModelData.fromjson(json['data']) : null;
  }

}

class CategoriesModelData
{
    int? current_page;
    List<PageData> data = [];
    String? first_page_url;

    CategoriesModelData.fromjson(Map<String,dynamic> json)
    {
      json['data'].forEach((element)
      {
        data.add(PageData.fromjson(element));
      });
      current_page = json['current_page'];
      first_page_url = json['first_page_url'];
    }

}



  class PageData
  {
    int? id;
    String? name;
    String? image;

    PageData.fromjson(Map<String,dynamic> json)
    {
      id = json['id'];
      name = json['name'];
      image = json['image'];
    }
  }