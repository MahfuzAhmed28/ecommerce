import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/core/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/core/widgets/show_snack_bar_message.dart';
import 'package:ecommerce/features/auth/ui/controllers/auth_controller.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/common/controllers/add_to_cart_contoller.dart';
import 'package:ecommerce/features/products/ui/controllers/product_details_controller.dart';
import 'package:ecommerce/features/products/ui/controllers/product_list_controller.dart';
import 'package:ecommerce/features/products/ui/widgets/color_picker.dart';
import 'package:ecommerce/features/products/ui/widgets/increment_decrement_counter_widget.dart';
import 'package:ecommerce/features/products/ui/widgets/product_image_carousel_slider.dart';
import 'package:ecommerce/features/products/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  static const String name='/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  final ProductDetailsController _productDetailsController=ProductDetailsController();
  final AddToCartController _addToCartController=AddToCartController();

  String? _selectedColor;
  String? _selectedsize;
  @override
  void initState() {
    super.initState();
    _productDetailsController.getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: GetBuilder(
        init: _productDetailsController,
        builder: (controller) {
          if(controller.inProgress){
            return CenteredCircularProgressIndicator();
          }
          if(controller.errorMessage!=null){
            return Center(
              child: Text(controller.errorMessage!),
            );
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImageCarouselSlider(imageList: controller.product.photos,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.product.title,style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,),
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star,color: Colors.amber,size: 20,),
                                              Text('${controller.product.rating}'),
                                            ],
                                          ),
                                          TextButton(onPressed: () {}, child: Text('Reviews')),
                                          Card(
                                            color: AppColors.themeColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.favorite_outline,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IncrementDecrementCounterWidget(
                                  onChange: (int value) {
                                    print(value);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 16,),
                            ColorPicker(
                              colors: controller.product.colors,
                              onChange: (selectedColor){
                                print(selectedColor);
                                _selectedColor=selectedColor;
                              },
                            ),
                            SizedBox(height: 16,),
                            SizePicker(
                              sizes: controller.product.sizes,
                              onChange: (selectedSize){
                                print(selectedSize);
                                _selectedsize=selectedSize;
                              },
                            ),
                            SizedBox(height: 16,),
                            Text('Description',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                            ),),
                            SizedBox(height: 8,),
                            Text(controller.product.description,style: TextStyle(
                              color: Colors.grey
                            ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildPriceAndAddToCartSection(controller.product.sizes.isNotEmpty,controller.product.colors.isNotEmpty)
            ],
          );
        }
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection(bool isSizeAvailable, bool isColorsAvailable) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price'),
              Text('\$1000',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.themeColor),
              )
            ],
          ),
          SizedBox(
            width: 140,
            child: GetBuilder(
              init: _addToCartController,
              builder: (controller) {
                return Visibility(
                  visible: controller.inProgress==false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () async {
                      if(isSizeAvailable && _selectedsize==null){
                        ShowSnackBarMessage(context, 'Pleases select your size',true);
                        return;
                      }
                      if(isColorsAvailable && _selectedColor==null){
                        ShowSnackBarMessage(context, 'Please select a color',true);
                        return;
                      }
                      if(Get.find<AuthController>().isValidUser()==false){
                        Get.to(()=>SignInScreen());
                        return;
                      }
                      final bool isSuccess=await _addToCartController.addToCart(_productDetailsController.product.id);
                      if(isSuccess){
                        ShowSnackBarMessage(context, 'Added to cart');
                      }
                      else{
                        ShowSnackBarMessage(context, _addToCartController.errorMessage!,true);
                      }
                    },
                    child: Text('Add to cart'),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
