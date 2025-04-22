import 'package:ecommerce/app/app_urls.dart';
import 'package:ecommerce/core/network_caller/network_caller.dart';
import 'package:ecommerce/features/common/data/models/slide_model.dart';
import 'package:get/get.dart';

class HomeSliderController extends GetxController{
  bool _getSliderInProgress=false;
  bool get getSliderInProgress=>_getSliderInProgress;

  List<SlideModel> _slideList=[];
  List<SlideModel> get sliders => _slideList;

  String? _errorMessage;
  String? get errorMessage=> _errorMessage;

  Future<bool> getSliders() async{
    bool isSuccess=false;
    _getSliderInProgress=true;
    update();

    final NetworkResponse response=await Get.find<NetworkCaller>().getRequest(url: AppUrls.sliderUrl);
    if(response.isSuccess){
      List<SlideModel> list=[];
      for(Map<String,dynamic> data in response.responseData!['data']['results']){
        list.add(SlideModel.fromJson(data));
      }
      _slideList=list;
      isSuccess=true;
      _errorMessage=null;
      print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    }
    else{
      _errorMessage=response.errorMessage;
    }
    _getSliderInProgress=false;
    update();
    return isSuccess;

  }
}