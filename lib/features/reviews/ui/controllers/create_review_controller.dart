import 'package:ecommerce/app/app_urls.dart';
import 'package:ecommerce/core/network_caller/network_caller.dart';
import 'package:ecommerce/features/reviews/data/models/create_review_model.dart';
import 'package:get/get.dart';

class CreateReviewController extends GetxController{
  bool _inProgress=false;
  String? _errorMessage;

  bool get inProgress=>_inProgress;
  String? get errorMessage=> _errorMessage;

  Future<bool> createReview(CreateReviewModel createReviewModel) async{
    bool isSuccess=false;
    _inProgress=true;
    update();
    NetworkResponse response= await Get.find<NetworkCaller>().postRequest(url: AppUrls.createReviewUrl,body: createReviewModel.toJson());
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