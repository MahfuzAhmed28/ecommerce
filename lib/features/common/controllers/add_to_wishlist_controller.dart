import 'package:ecommerce/app/app_urls.dart';
import 'package:ecommerce/core/network_caller/network_caller.dart';
import 'package:get/get.dart';

class AddToWishlistController extends GetxController{
  bool _inProgress=false;
  String? _errorMessage;

  bool get inProgress=>_inProgress;
  String? get errorMessage=>_errorMessage;

  Future<bool> addToWish(String productId) async{
    bool isSuccess=false;
    _inProgress=true;
    update();
    final NetworkResponse response=await Get.find<NetworkCaller>().postRequest(url: AppUrls.addToWishUrl,body:{'product': productId});

    if(response.isSuccess){
      isSuccess=true;
      _errorMessage=null;
    }
    else{
      _errorMessage=response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}