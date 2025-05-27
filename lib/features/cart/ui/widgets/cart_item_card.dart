import 'package:ecommerce/core/network_caller/network_caller.dart';
import 'package:ecommerce/core/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/core/widgets/show_snack_bar_message.dart';
import 'package:ecommerce/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce/features/cart/ui/controllers/cart_list_controller.dart';
import 'package:ecommerce/features/products/ui/widgets/increment_decrement_counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard(this.cartItemModel, {super.key});

  final CartItemModel cartItemModel;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  final CartListController _cartListController=Get.find<CartListController>();
  bool _deleteInProgress=false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.network(
              '',
              width: 100,
              height: 100,
              errorBuilder: (_,__,___){
                return Icon(Icons.error_outline);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.cartItemModel.productModel.title,style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),),
                            Row(
                              children: [
                                Text('Color: ${widget.cartItemModel.color}'),
                                Text('Size: ${widget.cartItemModel.size}'),
                              ],
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _deleteInProgress==false,
                        replacement: CenteredCircularProgressIndicator(),
                        child: IconButton(
                          onPressed: () async {
                            _deleteInProgress=true;
                            setState(() {});
                            final bool isSuccess= await Get.find<CartListController>().removeFromCartList(widget.cartItemModel.id);
                            _deleteInProgress=false;
                            setState(() {});
                            if(isSuccess==false){
                              ShowSnackBarMessage(context, Get.find<CartListController>().removeFromCartErrorMessage!,true);
                            }
                          },
                          icon: Icon(Icons.delete),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${widget.cartItemModel.productModel.currentPrice}'),
                      SizedBox(
                        width: 80,
                        child: FittedBox(
                          child: IncrementDecrementCounterWidget(
                            onChange: (int count){
                              Get.find<CartListController>().updateProduct(widget.cartItemModel.id, count);
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
