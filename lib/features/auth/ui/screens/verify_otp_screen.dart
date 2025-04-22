import 'dart:async';

import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/core/extensions/localization_extensions.dart';
import 'package:ecommerce/core/widgets/show_snack_bar_message.dart';
import 'package:ecommerce/features/auth/data/models/verify_otp_model.dart';
import 'package:ecommerce/features/auth/ui/controllers/verify_otp_controller.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_up_screen.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});

  static const String name='/verify-otp-screen';
  final String email;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  final VerifyOtpController _verifyOtpController=Get.find<VerifyOtpController>();

  final TextEditingController _otpTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  RxInt _currentTime=30.obs;

  void _startTimer(){
    _currentTime.value=30;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(_currentTime.value==0){
        timer.cancel();
      }else{
        _currentTime.value=_currentTime.value-1;
      }
    });
  }

  @override
  void initState() {

    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 60,),
                AppLogo(),
                SizedBox(height: 24,),
                Text(context.localization.enterYourOtpCode,style: textTheme.titleLarge,),
                SizedBox(height: 8,),
                Text(context.localization.aFourDigitCodeHasBeenSent,style: TextStyle(color: Colors.grey,fontSize: 16),),
                SizedBox(height: 16,),
                PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  controller: _otpTEController,
                  appContext: context,
                  validator: (String? value){
                    if((value?.length ?? 0)<4){
                      return 'Please enter 4 digits otp code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8,),
                SizedBox(height: 16,),
                ElevatedButton(
                  onPressed: _onTapVerifyOtpButton,
                  child: Text(context.localization.verify),
                ),
                SizedBox(height: 16,),
                Obx(() {
                    return Column(
                      children: [
                        Visibility(
                          visible: _currentTime.value==0,
                          child: TextButton(
                            onPressed: () {
                              _startTimer();
                            },
                            child: Text('Resend Otp'),
                          ),
                        ),
                        Visibility(
                          visible: _currentTime.value!=0,
                          child: TextButton(
                            onPressed: () {},
                            child: Text('Resend Otp in ${_currentTime.value}'),
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _onTapVerifyOtpButton(){
    if(_formKey.currentState!.validate()){
      _verfyOtp();
    }
  }

  Future<void> _verfyOtp() async{
    VerifyOtpModel verifyOtpModel=VerifyOtpModel(email: widget.email, otp: _otpTEController.text);

    final bool isSuccess= await _verifyOtpController.verifyOtp(verifyOtpModel);
    if(isSuccess){
      ShowSnackBarMessage(context, 'Otp has been verified! Please login');
      Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=>false);
    }
    else{
      ShowSnackBarMessage(context, _verifyOtpController.errorMessage!,true);
    }
  }
}
