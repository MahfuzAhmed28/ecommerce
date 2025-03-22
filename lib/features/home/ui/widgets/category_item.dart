import 'package:ecommerce/app/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 8),
          color: AppColors.themeColor.withOpacity(0.15),
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.computer,
              color: AppColors.themeColor,
              size:48,
            ),
          ),
        ),
        Text('Computers',
          style: TextStyle(
            color: AppColors.themeColor,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}