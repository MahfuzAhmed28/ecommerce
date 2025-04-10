import 'package:ecommerce/app/app.dart';
import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/core/extensions/localization_extensions.dart';
import 'package:ecommerce/core/widgets/centered_circular_progress_indicator.dart';
import 'package:ecommerce/core/widgets/show_snack_bar_message.dart';
import 'package:ecommerce/features/auth/data/models/sign_up_model.dart';
import 'package:ecommerce/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/verify_otp_screen.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name='/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _firstNameTEController=TextEditingController();
  final TextEditingController _lastNameTEController=TextEditingController();
  final TextEditingController _phoneTEController=TextEditingController();
  final TextEditingController _deliveryAddressTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  final SignUpController signUpController=Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
            child: _buildForm(textTheme),
          ),
        ),
    );
  }

  Widget _buildForm(TextTheme textTheme) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          SizedBox(height: 16,),
          AppLogo(),
          SizedBox(height: 24,),
          Text(context.localization.registerYourAccount,style: textTheme.titleLarge,),
          SizedBox(height: 8,),
          Text(context.localization.getStartedWithYourDetails,style: TextStyle(color: Colors.grey,fontSize: 16),),
          SizedBox(height: 16,),
          TextFormField(
            controller: _emailTEController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: context.localization.email
            ),
            validator: (String? value){
              String email=value ?? '';
              if(!EmailValidator.validate(email)){
                return 'Enter your email';
              }
              return null;
            },
          ),
          SizedBox(height: 8,),
          TextFormField(
            controller: _firstNameTEController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: context.localization.firstName
            ),
            validator: (String? value){
              if(value?.trim().isEmpty ?? true){
                return 'Enter your first name';
              }
              return null;
            },
          ),
          SizedBox(height: 8,),
          TextFormField(
            controller: _lastNameTEController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                hintText: context.localization.lastName
            ),
            validator: (String? value){
              if(value?.trim().isEmpty ?? true){
                return 'Enter your last name';
              }
              return null;
            },
          ),
          SizedBox(height: 8,),
          TextFormField(
            controller: _phoneTEController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: context.localization.phone
            ),
            validator: (String? value){
              String phoneNumber=value ?? '';
              RegExp regExp=RegExp(r'^(?:\+88|88)?01[3-9]\d{8}$');
              if(regExp.hasMatch(phoneNumber)==false){
                return 'Enter your valid phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 8,),
          TextFormField(
            controller: _passwordTEController,
            decoration: InputDecoration(
                hintText: context.localization.password
            ),
            validator: (String? value){
              if((value?.isEmpty ?? true) || value!.length<6){
                return 'Enter password more than 6 letters';
              }
              return null;
            },
          ),
          SizedBox(height: 8,),
          TextFormField(
            controller: _deliveryAddressTEController,
            textInputAction: TextInputAction.next,
            maxLines: 3,
            decoration: InputDecoration(
                hintText: context.localization.deliveryAddress,
                contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 16)
            ),
            validator: (String? value){
              if(value?.trim().isEmpty ?? true){
                return 'Enter your delivery address';
              }
              return null;
            },
          ),
      
          SizedBox(height: 16,),
          GetBuilder<SignUpController>(
            builder: (controller) {
              return Visibility(
                visible: controller.signUpInProgress==false,
                replacement: CenteredCircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: _onTapSignUpButton,
                  child: Text(context.localization.signUp),
                ),
              );
            }
          ),
          SizedBox(height: 16,),
          RichText(
            text: TextSpan(
              text: "Already have account? ",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
              children:[
                TextSpan(
                  text: 'Sign In',
                  style: TextStyle(
                    color: AppColors.themeColor,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton,
                ),
              ],
            )
          )
        ],
      ),
    );
  }

  void _onTapSignUpButton() async{
    if(_formKey.currentState!.validate()){
      SignUpModel signUpModel=SignUpModel(
        email: _emailTEController.text.trim(),
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        phone: _phoneTEController.text.trim(),
        password: _passwordTEController.text,
        deliveryAddress: _deliveryAddressTEController.text.trim()
      );
      final bool isSuccess= await signUpController.signUp(signUpModel);
      if(isSuccess){
        Navigator.pushNamed(context, VerifyOtpScreen.name);
      }
      else{
        ShowSnackBarMessage(context, signUpController.errorMessage!,true);
      }
    }
  }

  void _onTapSignInButton(){
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _deliveryAddressTEController.dispose();
    _passwordTEController.dispose();
    _phoneTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    super.dispose();
  }
}
