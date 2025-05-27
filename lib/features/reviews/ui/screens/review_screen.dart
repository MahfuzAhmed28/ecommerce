import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/core/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/features/reviews/ui/controllers/review_list_controller.dart';
import 'package:ecommerce/features/reviews/ui/screens/create_review.dart';
import 'package:ecommerce/features/reviews/ui/widgets/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.productID});

  final String productID;

  static const String name='/review-screen';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final ReviewListController _reviewListController=Get.find<ReviewListController>();
  @override
  void initState() {
    super.initState();
    _reviewListController.getReviewList(widget.productID);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: GetBuilder<ReviewListController>(
        builder: (controller) {
          if(controller.inProgress){
            return CenteredCircularProgressIndicator();
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: controller.reviewList.length,
                    itemBuilder: (context,index){
                      return ReviewWidget(reviewModel: controller.reviewList[index],);
                    },
                  ),
                ),
              ),
              Container(
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
                    Row(
                      children: [
                        Text('Reviews'),
                        SizedBox(width: 5,),
                        Text('(${_reviewListController.reviewList.length})'),
                      ],
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.themeColor,
                      child: IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, CreateReview.name);
                        },
                        icon: Icon(Icons.add,color: Colors.white,size: 25,),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}


