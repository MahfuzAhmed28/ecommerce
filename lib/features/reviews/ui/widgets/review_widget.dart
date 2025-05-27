import 'package:ecommerce/features/reviews/data/models/review_model.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    super.key, required this.reviewModel,
  });

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        title: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey.shade200,
              child: Icon(Icons.person_outline,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${reviewModel.firstName} ${reviewModel.lastName}',style: TextStyle(
                fontWeight: FontWeight.w500,
              ),),
            ),
          ],
        ),
        subtitle: Text('${reviewModel.comment}',style: TextStyle(
          color: Colors.grey,
        ),),
      ),
    );
  }
}