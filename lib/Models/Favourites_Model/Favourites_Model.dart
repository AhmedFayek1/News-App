class FavouritesModel {
  bool? status;
  String? message;

  FavouritesModel.fromjson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}