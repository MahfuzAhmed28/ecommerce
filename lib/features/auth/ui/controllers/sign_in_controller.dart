import 'package:ecommerce/app/app_urls.dart';
import 'package:ecommerce/core/network_caller/network_caller.dart';
import 'package:ecommerce/features/auth/data/models/sign_in_request_model.dart';
import 'package:ecommerce/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce/features/auth/data/models/user_model.dart';
import 'package:ecommerce/features/auth/ui/controllers/auth_controller.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{
  bool _inProgress=false;
  bool get signInProgress=>_inProgress;

  String? _errorMessage;
  String? get errorMessage=>_errorMessage;

  Future<bool> signIn(SignInRequestModel signInRequestModel) async{
    bool isSuccess=false;
    _inProgress=true;
    update();

    NetworkResponse response= await Get.find<NetworkCaller>().postRequest(
      url: AppUrls.signInUrl,
      body: signInRequestModel.toJson());

    if(response.isSuccess){
      //Save Data
      UserModel userModel=UserModel.fromJson(response.responseData!['data']['user']);
      //Save Token
      String accessToken=response.responseData!['data']['token'];
      await Get.find<AuthController>().saveUserData(accessToken, userModel);
      _errorMessage=null;
      isSuccess=true;
    }
    else{
      _errorMessage=response.errorMessage;
    }
    _inProgress=false;
    update();

    return isSuccess;
  }
}