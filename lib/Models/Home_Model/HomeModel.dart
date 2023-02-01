class HomeModel
{
  bool? status;
  //String? message;
  HomeDataModel? data;

  HomeModel.fromjson(Map<String,dynamic> json)
  {
    status = json['status'];
    //message = json['message'];
    data = json['data']!= null ?  HomeDataModel.fromjson(json['data']):null;  }


}


class HomeDataModel
{
  late List<BannerModel>? banners = [];
  late List<ProductModel> ?products = [];

  HomeDataModel.fromjson(Map<String,dynamic> json)
  {
    json['banners'].forEach((element) {
      banners!.add(BannerModel.fromjson(element));
    });

    json['products'].forEach((element) {
      products!.add(ProductModel.fromjson(element));
    });
  }
}

class BannerModel
{
  int? id;
  String? image;

  BannerModel.fromjson(Map<String,dynamic> json)
  {
      id = json['id'];
      image = json['image'];
  }
}

class ProductModel
{
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;

  ProductModel.fromjson(Map<String,dynamic> json)
  {
      id = json['id'];
      price = json['price'];
      old_price = json['old_price'];
      discount = json['discount'];
      image = json['image'];
      name = json['name'];
      in_favorites = json['in_favorites'];
      in_cart = json['in_cart'];
  }
}