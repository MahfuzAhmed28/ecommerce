import 'package:ecommerce/app/app_urls.dart';
import 'package:ecommerce/core/network_caller/network_caller.dart';
import 'package:ecommerce/features/common/data/models/category_model.dart';
import 'package:ecommerce/features/products/data/models/product_model.dart';
import 'package:get/get.dart';

class NewProductSectionController extends GetxController{
  int _perPageDataCount=10;
  int _currentPage=0;
  int? _totalPage;

  bool _isInitialLoading=true;
  bool _isLoading=false;

  List<ProductModel> _productList=[];

  String? _errorMessage;
  String? get errorMessage=> _errorMessage;
  int? get totalPage=>_totalPage;
  List<ProductModel> get productList=> _productList;

  bool get isLoading=>_isLoading;
  bool get isInitialLoading=>_isInitialLoading;

  Future<bool> getNewProductList() async{
    if(_totalPage!=null && _currentPage>_totalPage!){
      return true;
    }
    bool isSuccess=false;
    _currentPage++;
    if(!_isInitialLoading){
      _isLoading=true;
    }
    update();
    final NetworkResponse response= await Get.find<NetworkCaller>().getRequest(
        url: AppUrls.newProductListUrl,
        queryParams: {
          'count':_perPageDataCount,
          'page':_currentPage,
          'tag':'new'
        }
    );

    if(response.isSuccess){
      List<ProductModel> list=[];
      var result = response.responseData!['data']['results'];
      if(result is List){
        for(Map<String,dynamic> data in response.responseData!['data']['results']){
          list.add(ProductModel.fromJson(data));
        }
      }

      _productList.addAll(list);
      _errorMessage=null;
      _totalPage=response.responseData!['data']['last_page'];
      isSuccess=true;
    }
    else{
      _errorMessage=response.errorMessage;
    }
    if(!_isInitialLoading){
      _isLoading=false;
    }
    else{
      _isInitialLoading=false;
    }
    update();
    return isSuccess;
  }

  Future<bool> refreshList(){
    _currentPage=0;
    _productList=[];
    _isInitialLoading=true;
    return getNewProductList();
  }
}