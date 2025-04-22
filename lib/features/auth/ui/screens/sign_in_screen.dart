import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/core/extensions/localization_extensions.dart';
import 'package:ecommerce/core/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/core/widgets/show_snack_bar_message.dart';
import 'package:ecommerce/features/auth/data/models/sign_in_request_model.dart';
import 'package:ecommerce/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_up_screen.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo.dart';
import 'package:ecommerce/features/common/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name='/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
  final SignInController _signInController=Get.find<SignInController>();
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 60,),
              AppLogo(),
              SizedBox(height: 24,),
              Text(context.localization.welcomeBack,style: textTheme.titleLarge,),
              SizedBox(height: 8,),
              Text(context.localization.enterYourEmailAndPassword,style: TextStyle(color: Colors.grey,fontSize: 16),),
              SizedBox(height: 16,),
              TextFormField(
                controller: _emailTEController,
                decoration: InputDecoration(
                  hintText: context.localization.email
                ),
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: _passwordTEController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: context.localization.password
                ),
              ),
              SizedBox(height: 16,),
              GetBuilder<SignInController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.signInProgress==false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSignInButton,
                      child: Text(context.localization.signIn),
                    ),
                  );
                }
              ),
              SizedBox(height: 16,),
              RichText(
                text: TextSpan(
                  text: "Don't have account? ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  children:[
                    TextSpan(
                      text: 'Sign up',
                      style: TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton,
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton() async{
    SignInRequestModel _signInRequestModel=SignInRequestModel(email: _emailTEController.text.trim(), password: _passwordTEController.text);
    final bool isSuccess=await _signInController.signIn(_signInRequestModel);

    if(isSuccess){
      print("Success");
      Navigator.pushNamedAndRemoveUntil(context, MainBottomNavBarScreen.name, (value) => false);
    }
    else{
      ShowSnackBarMessage(context, _signInController.errorMessage!,true);
    }
  }

  void _onTapSignUpButton(){
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
