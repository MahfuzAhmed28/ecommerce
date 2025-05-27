import 'package:ecommerce/core/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/core/widgets/show_snack_bar_message.dart';
import 'package:ecommerce/features/reviews/data/models/create_review_model.dart';
import 'package:ecommerce/features/reviews/ui/controllers/create_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReview extends StatefulWidget {
  const CreateReview({super.key});

  static const String name='/-create-review';

  @override
  State<CreateReview> createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {

  final CreateReviewController _createReviewController=Get.find<CreateReviewController>();
  final TextEditingController _firstNameTEController=TextEditingController();
  final TextEditingController _lastNameTEController=TextEditingController();
  final TextEditingController _writeReviewTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50,),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: InputDecoration(
                    hintText: 'First Name'
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: InputDecoration(
                      hintText: 'Last Name'
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _writeReviewTEController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: 'Write Review'
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Write your review';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                GetBuilder<CreateReviewController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress==false,
                      replacement: CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            return null;
                          }
                        },
                        child: Text('Submit'),
                      ),
                    );
                  }
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  void _onTapCreateReviewButton() async{
    CreateReviewModel createReviewModel=CreateReviewModel(
        firstName: _firstNameTEController.toString().trim(),
        lastName: _lastNameTEController.toString().trim(),
        review: _writeReviewTEController.toString().trim(),
    );

    bool isSuccess= await _createReviewController.createReview(createReviewModel);
    if(isSuccess){
      ShowSnackBarMessage(context, "Review Successfully added");
    }
    else{
      ShowSnackBarMessage(context, _createReviewController.errorMessage!);
    }

  }
}
