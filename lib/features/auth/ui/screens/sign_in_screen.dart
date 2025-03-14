import 'package:ecommerce/app/app_colors.dart';
import 'package:ecommerce/core/extensions/localization_extensions.dart';
import 'package:ecommerce/features/auth/ui/widgets/app_logo.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name='sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                decoration: InputDecoration(
                  hintText: context.localization.email
                ),
              ),
              SizedBox(height: 8,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: context.localization.password
                ),
              ),
              SizedBox(height: 16,),
              ElevatedButton(
                onPressed: () {
                  FirebaseCrashlytics.instance.log('Enter Sign In Button');
                  throw Exception('My Custome Error1');
                },
                child: Text(context.localization.signIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
