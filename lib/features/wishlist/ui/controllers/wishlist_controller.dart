import 'package:ecommerce/app/app_urls.dart';
import 'package:ecommerce/core/network_caller/network_caller.dart';
import 'package:ecommerce/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce/features/products/data/models/product_model.dart';
import 'package:ecommerce/features/wishlist/data/models/wishlist_model.dart';
import 'package:get/get.dart';

class WishListController extends GetxController{
  bool _getWishListInProgress=false;
  String? _errorMessage;

  bool get getWishListInProgress=>_getWishListInProgress;
  String? get errorMessage=>_errorMessage;


  List<WishListModel> _productList = [];
  List<WishListModel> get productList => _productList;

  Future<bool> getWishList() async{
    bool isSuccess=false;
    _getWishListInProgress=true;
    update();
    NetworkResponse response=await Get.find<NetworkCaller>().getRequest(url: AppUrls.wishListUrl);
    if (response.isSuccess) {
      List<WishListModel> list = [];
      for (Map<String, dynamic> data in response.responseData!['data']
      ['results']) {
        list.add(WishListModel.fromJson(data));
      }
      _productList.addAll(list);

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getWishListInProgress=false;
    update();
    return isSuccess;
  }



}

