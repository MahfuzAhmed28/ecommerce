import 'package:ecommerce/core/network_caller/network_caller.dart';
import 'package:ecommerce/features/auth/ui/controllers/auth_controller.dart';
import 'package:ecommerce/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:ecommerce/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:ecommerce/features/auth/ui/controllers/verify_otp_controller.dart';
import 'package:ecommerce/features/cart/ui/controllers/cart_list_controller.dart';
import 'package:ecommerce/features/common/controllers/add_to_wishlist_controller.dart';
import 'package:ecommerce/features/common/controllers/category_controller.dart';
import 'package:ecommerce/features/common/controllers/home_slider_controller.dart';
import 'package:ecommerce/features/common/controllers/main_bottom_nav_bar_controller.dart';
import 'package:ecommerce/features/home/ui/controllers/new_product_section_controller.dart';
import 'package:ecommerce/features/products/ui/controllers/product_list_controller.dart';
import 'package:ecommerce/features/reviews/ui/controllers/create_review_controller.dart';
import 'package:ecommerce/features/reviews/ui/controllers/review_list_controller.dart';
import 'package:ecommerce/features/wishlist/ui/controllers/wishlist_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(NetworkCaller());
    Get.put(HomeSliderController());
    Get.put(CategoryController());
    Get.put(ProductListController());
    Get.put(MainBottomNavBarController());
    Get.put(SignUpController());
    Get.lazyPut(()=>VerifyOtpController());     //Lazy Put
    Get.put(SignInController());
    Get.put(CartListController());
    Get.put(WishListController());
    Get.put(ReviewListController());
    Get.put(NewProductSectionController());
    Get.put(CreateReviewController());
    //Get.put(AddToWishlistController());

  }

}