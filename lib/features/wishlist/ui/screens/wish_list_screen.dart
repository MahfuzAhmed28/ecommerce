import 'package:ecommerce/core/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/features/common/controllers/main_bottom_nav_bar_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/product_card.dart';
import 'package:ecommerce/features/wishlist/ui/controllers/wishlist_controller.dart';
import 'package:ecommerce/features/wishlist/ui/widgets/wish_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final WishListController _wishListController = Get.find<WishListController>();
  final ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    _wishListController.getWishList();
    _scrollController.addListener(_loadData);
  }

  void _loadData() {
    if (_scrollController.position.extentAfter < 300) {
      _wishListController.getWishList();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.find<MainBottomNavBarController>().backToHome();
          },
          icon: Icon(Icons.arrow_back_ios)),
        title: Text('WishList'),
      ),
      body: GetBuilder<WishListController>(
        builder: (controller) {
          if(controller.getWishListInProgress){
            return CenteredCircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
              ),
              itemCount: controller.productList.length,
              itemBuilder: (context, index){
                return FittedBox(child: WishCard(wishListModel: controller.productList[index],));
              },
            ),
          );
        }
      ),
    );
  }
}
