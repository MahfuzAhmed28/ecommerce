import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/app/assets_path.dart';
import 'package:ecommerce/features/products/data/models/product_model.dart';
import 'package:ecommerce/features/products/ui/screens/product_details_screen.dart';
import 'package:ecommerce/features/wishlist/data/models/wishlist_model.dart';
import 'package:flutter/material.dart';

class WishCard extends StatelessWidget {
  const WishCard({
    super.key, required this.wishListModel,
  });

  final WishListModel wishListModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.name,arguments: wishListModel.id);
      },
      child: Card(
        color: Colors.white,
        child: SizedBox(
          width: 140,
          child: Column(
            children: [
              Container(
                height: 120,
                width: 140,
                decoration: BoxDecoration(
                    color: AppColors.themeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    image: wishListModel.photos.isNotEmpty ? DecorationImage(
                      image: NetworkImage(wishListModel.photos.first),
                      fit: BoxFit.cover,
                    ): null
                ),
                child: wishListModel.photos.isEmpty ? Icon(Icons.error):null,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wishListModel.title,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${wishListModel.current_price}',
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Card(
                          color: AppColors.themeColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.favorite_outline,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}