import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/features/reviews/ui/screens/create_review.dart';
import 'package:ecommerce/features/reviews/ui/widgets/review_widget.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  static const String name='/review-screen';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context,index){
                  return ReviewWidget();
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
                    Text('(1000)'),
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
      ),
    );
  }
}


