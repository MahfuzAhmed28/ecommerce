import 'package:ecommerce/app/app_urls.dart';
import 'package:ecommerce/core/network_caller/network_caller.dart';
import 'package:ecommerce/features/reviews/data/models/review_model.dart';
import 'package:get/get.dart';

class ReviewListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<ReviewModel> _reviewList = [];

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<ReviewModel> get reviewList => _reviewList;

  Future<bool> getReviewList(String productId) async {
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx$productId');
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        url: AppUrls.reviewListUrl,
        queryParams: {
          'product':productId,
        });

    if (response.isSuccess) {
      try {
        List<dynamic> results = response.responseData?['data']?['results'] ?? [];

        // Parse and filter by matching productId
        List<ReviewModel> filteredList = results
            .map((e) => ReviewModel.fromJson(e))
            .where((review) => review.productId == productId)
            .toList();

        _reviewList = filteredList;
        _errorMessage = null;
        isSuccess = true;
      } catch (e) {
        _errorMessage = "Data parsing error: $e";
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
