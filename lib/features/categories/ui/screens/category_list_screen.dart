import 'package:ecommerce/features/common/controllers/main_bottom_nav_bar_controller.dart';
import 'package:ecommerce/features/common/ui/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_,__){
        Get.find<MainBottomNavBarController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.find<MainBottomNavBarController>().backToHome();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Categories'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: 16,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisSpacing: 16),
            itemBuilder: (context,index){
              return FittedBox(child: CategoryItem());
            },
          ),
        ),
      ),
    );
  }
}
