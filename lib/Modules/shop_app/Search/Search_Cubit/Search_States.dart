
import '../../../../Models/Search_Model/Search_Model.dart';

abstract class SearchStates {}

class ShopSearchInitialState extends SearchStates {}

class ShopSearchLoadingState extends SearchStates {}

class ShopSearchSuccessState extends SearchStates {
  final SearchModel? searchModel;

  ShopSearchSuccessState(this.searchModel);
}

class ShopSearchErrorState extends SearchStates {}

