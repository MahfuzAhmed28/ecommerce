import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/core/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/features/common/controllers/category_controller.dart';
import 'package:ecommerce/features/common/controllers/main_bottom_nav_bar_controller.dart';
import 'package:ecommerce/features/common/data/models/category_model.dart';
import 'package:ecommerce/features/home/ui/widgets/app_bar_action_button.dart';
import 'package:ecommerce/features/common/ui/widgets/category_item.dart';
import 'package:ecommerce/features/common/ui/widgets/product_card.dart';
import 'package:ecommerce/features/home/ui/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../widgets/home_carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchTextField(),
              SizedBox(height: 16,),
              HomeCarouselSlider(),
              SizedBox(height: 16,),
              SectionHeader(
                title: 'Category',
                seeAll: () {
                  Get.find<MainBottomNavBarController>().moveToCategory();
                },
              ),
              SizedBox(height: 16,),
              _buildCategoriesSection(),
              SizedBox(height: 16,),
              SectionHeader(
                title: 'Popular',
                seeAll: () {},
              ),
              SizedBox(height: 16,),
              _buildProductSection(),
              SizedBox(height: 16,),
              SectionHeader(
                title: 'Special',
                seeAll: () {},
              ),
              SizedBox(height: 16,),
              _buildProductSection(),
              SizedBox(height: 16,),
              SectionHeader(
                title: 'New',
                seeAll: () {},
              ),
              SizedBox(height: 16,),
              _buildProductSection(),
              SizedBox(height: 16,),

            ],
          ),
        ),
      ),
    );
  }

Widget _buildCategoriesSection() {
  return GetBuilder<CategoryController>(
    builder: (controller) {
      if(controller.isInitialLoading){
        return SizedBox(
          child: CenteredCircularProgressIndicator(),
          height: 100,
        );
      }
      List<CategoryModel> list = controller.categoryList.length > 10
          ? controller.categoryList.sublist(0, 10)
          : controller.categoryList;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: list.map((e){
            return CategoryItem(categoryModel: e,);
          }).toList()
        ),
      );
    }
  );
}
  Widget _buildProductSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          /*ProductCard(productModel: ,),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),*/
        ],
      ),
    );
  }

  Widget _buildSearchTextField() {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetsPath.logoNavSvg),
      actions: [
        AppBarActionButtion(icon: Icons.person_outline,onTap: () {},),
        const SizedBox(width: 8,),
        AppBarActionButtion(icon: Icons.call,onTap: () {},),
        const SizedBox(width: 8,),
        AppBarActionButtion(icon: Icons.notifications_active_outlined,onTap: () {},),
      ],
    );
  }
}










