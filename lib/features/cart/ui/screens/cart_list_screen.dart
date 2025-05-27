import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/core/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce/features/cart/ui/controllers/cart_list_controller.dart';
import 'package:ecommerce/features/cart/ui/screens/payment_screen.dart';
import 'package:ecommerce/features/cart/ui/widgets/cart_item_card.dart';
import 'package:ecommerce/features/common/controllers/main_bottom_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {

  final CartListController _cartListController=Get.find<CartListController>();
  @override
  void initState() {
    super.initState();
    _cartListController.getCartList();
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
        title: Text('Cart list'),
      ),
      body: GetBuilder<CartListController>(
        builder: (controller) {
          if(controller.getCartListInProgress){
            return CenteredCircularProgressIndicator();
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: controller.cartItemList.length,
                    itemBuilder: (context,index){
                      CartItemModel cartItem=controller.cartItemList[index];
                      return CartItemCard(cartItem);
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total price'),
                        Text('\$${_cartListController.totalPrice}',style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.themeColor,
                        ),),
                      ],

                    ),
                    SizedBox(
                      width: 140,
                      child: ElevatedButton(
                        onPressed: (){
                          //Navigator.pushNamed(context, PaymentScreen.name,arguments: _cartListController.totalPrice.toDouble());
                          _paymentMethod();
                        },
                        child: Text('Check Out'),
                      ),
                    )

                  ],
                ),

              )
            ],
          );
        }
      ),
    );

  }

  void _paymentMethod() async {

    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "Food",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: "abc68305040a6293", // Replace with real ID
        store_passwd: "abc68305040a6293@ssl", // Replace with real password
        total_amount: _cartListController.totalPrice.toDouble(),
        tran_id: "TXN_${DateTime.now().millisecondsSinceEpoch}",
      ),
    );

    final response=await sslcommerz.payNow();
    if(response.status=="VALID"){
      _successResponse();
    }
    if(response.status=='FAILED'){
      _failedResponse();
    }
  }

  void _failedResponse(){
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: Text('Payment failed'),
        content: Column(
          children: [
            Text('Your payment has been failed. Please try again!')
          ],
        ),
        actions: [
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('Okay'))
        ],
      );
    });
  }

  void _successResponse() {
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title: Text('Payment success'),
        content: Column(
          children: [
            Text('Your payment hasbenn receive. Order placed')
          ],
        ),
        actions: [
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('Okay'))
        ],
      );
    });
  }
}
