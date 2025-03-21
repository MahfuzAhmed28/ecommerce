import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/core/extensions/localization_extensions.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/verify_otp_screen.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: _buildForm(textTheme),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(TextTheme textTheme) {
    return Column(
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
        ),
        SizedBox(height: 8,),
        TextFormField(
          controller: _firstNameTEController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              hintText: context.localization.firstName
          ),
        ),
        SizedBox(height: 8,),
        TextFormField(
          controller: _lastNameTEController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              hintText: context.localization.lastName
          ),
        ),
        SizedBox(height: 8,),
        TextFormField(
          controller: _phoneTEController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: context.localization.phone
          ),
        ),
        SizedBox(height: 8,),
        TextFormField(
          controller: _passwordTEController,
          decoration: InputDecoration(
              hintText: context.localization.password
          ),
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
        ),

        SizedBox(height: 16,),
        ElevatedButton(
          onPressed: _onTapVerifyOtpScreen,
          child: Text(context.localization.signUp),
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
    );
  }

  void _onTapVerifyOtpScreen(){
    Navigator.pushNamed(context, VerifyOtpScreen.name);
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
