import 'package:sixam_mart/data/api/api_checker.dart';
import 'package:sixam_mart/data/model/response/home_category_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';
import 'package:sixam_mart/data/repository/category_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;

  HomeCategoryController({@required this.categoryRepo});
  List<HomeCategoryModel> _categoryList;
  List<HomeCategoryModel> _subCategoryList;
  List<Item> _categoryItemList;
  List<Store> _categoryStoreList;
  List<Item> _searchItemList = [];
  List<Store> _searchStoreList = [];
  List<bool> _interestSelectedList;
  bool _isLoading = false;
  int _pageSize;
  int _restPageSize;
  bool _isSearching = false;
  int _subCategoryIndex = 0;
  String _type = 'all';
  bool _isStore = false;
  String _searchText = '';
  String _storeResultText = '';
  String _itemResultText = '';
  int _offset = 1;

  List<HomeCategoryModel> get categoryList => _categoryList;
  List<HomeCategoryModel> get subCategoryList => _subCategoryList;
  List<Item> get categoryItemList => _categoryItemList;
  List<Store> get categoryStoreList => _categoryStoreList;
  List<Item> get searchItemList => _searchItemList;
  List<Store> get searchStoreList => _searchStoreList;
  List<bool> get interestSelectedList => _interestSelectedList;
  bool get isLoading => _isLoading;
  int get pageSize => _pageSize;
  int get restPageSize => _restPageSize;
  bool get isSearching => _isSearching;
  int get subCategoryIndex => _subCategoryIndex;
  String get type => _type;
  bool get isStore => _isStore;
  String get searchText => _searchText;
  int get offset => _offset;

  Future<void> getCategoryList(bool reload, {bool allCategory = false}) async {
    if(_categoryList == null || reload) {
      _categoryList = null;
      Response response = await categoryRepo.getCategoryList(allCategory);
      if (response.statusCode == 200) {
        _categoryList = [];
        _interestSelectedList = [];
        response.body.forEach((category) {
          _categoryList.add(HomeCategoryModel.fromJson(category));
          _interestSelectedList.add(false);
        });
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }


  void toggleSearch() {
    _isSearching = !_isSearching;
    _searchItemList = [];
    if(_categoryItemList != null) {
      _searchItemList.addAll(_categoryItemList);
    }
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  Future<bool> saveInterest(List<int> interests) async {
    _isLoading = true;
    update();
    Response response = await categoryRepo.saveUserInterests(interests);
    bool _isSuccess;
    if(response.statusCode == 200) {
      _isSuccess = true;
    }else {
      _isSuccess = false;
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  void addInterestSelection(int index) {
    _interestSelectedList[index] = !_interestSelectedList[index];
    update();
  }

  void setRestaurant(bool isRestaurant) {
    _isStore = isRestaurant;
    update();
  }


}


