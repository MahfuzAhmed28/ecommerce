import 'package:ecommerce/core/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/features/common/data/models/category_model.dart';
import 'package:ecommerce/features/common/ui/widgets/product_card.dart';
import 'package:ecommerce/features/products/ui/controllers/product_list_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.category});

  final CategoryModel category;
  static const String name='/products';

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListController _productListController =ProductListController();
  ScrollController _scrollController=ScrollController();

  @override
  void initState() {
    super.initState();
    _productListController.getProductListByCategory(widget.category.id ?? '');
    _scrollController.addListener(_loadData);
  }

  void _loadData(){
    if(_scrollController.position.extentAfter<300){
      _productListController.getProductListByCategory(widget.category.id ?? '');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder(

          init: _productListController,
          builder: (context) {
            if(_productListController.isInitialLoading){
              return CenteredCircularProgressIndicator();
            }
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                    ),
                    itemCount: _productListController.productList.length,
                    controller: _scrollController,
                    itemBuilder: (context, index){
                      return FittedBox(child: ProductCard(productModel: _productListController.productList[index],));
                    },
                  ),
                ),
                Visibility(
                  visible: _productListController.isLoading,
                  child: LinearProgressIndicator(),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
