import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class AuthenticationLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? mainButtonTitle;
  final Widget? form;
  final bool showTermsText;
  final void Function()? onMainButtonTapped;
  final void Function()? onCreateAccountTapped;
  final void Function()? onForgotPassword;
  final void Function()? onBackPressed;
  final void Function()? onDummyLoginTapped;
  final void Function()? onGoogleButtonTapped;
  final void Function()? onAppleButtonTapped;
  final String? validationMessage;
  final String? releaseName;
  final bool busy;

  const AuthenticationLayout({
    Key? key,
    this.title,
    this.subtitle,
    this.mainButtonTitle,
    this.form,
    this.onMainButtonTapped,
    this.onCreateAccountTapped,
    this.onForgotPassword,
    this.onBackPressed,
    this.validationMessage,
    this.showTermsText = false,
    this.busy = false,
    this.onDummyLoginTapped,
    this.onGoogleButtonTapped,
    this.onAppleButtonTapped,
    this.releaseName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedWidthWithScaffoldLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            if (onBackPressed == null) verticalSpaceLarge,
            if (onBackPressed != null) verticalSpaceRegular,
            if (onBackPressed != null)
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: onBackPressed,
              ),
            Text(
              title!,
              style: textTheme(context).headline2,
            ),
            verticalSpaceSmall,
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: screenWidthPercentage(context, percentage: 0.7),
                child: Text(
                  subtitle!,
                ),
              ),
            ),
            verticalSpaceRegular,
            form!,
            verticalSpaceRegular,
            if (onForgotPassword != null)
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: onForgotPassword,
                    child: Text(
                      'Forget Password?',
                      style: textTheme(context).bodyText2!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    )),
              ),
            verticalSpaceRegular,
            if (validationMessage != null)
              Text(
                validationMessage!,
                style: TextStyle(
                  color: Colors.red,
                  //fontSize: kBodyTextSize,
                ),
              ),
            if (validationMessage != null) verticalSpaceRegular,
            GestureDetector(
              onTap: onMainButtonTapped,
              child: Container(
                width: double.infinity,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorSettings.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: busy
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : Text(
                        mainButtonTitle!,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
              ),
            ),
            if (onDummyLoginTapped != null) verticalSpaceSmall,
            if (onDummyLoginTapped != null)
              GestureDetector(
                onTap: onDummyLoginTapped,
                child: Container(
                  width: double.infinity,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorSettings.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: busy
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : Text(
                          "LOGIN TO TEST ACCOUNT",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                ),
              ),
            verticalSpaceRegular,
            if (onCreateAccountTapped != null)
              GestureDetector(
                onTap: onCreateAccountTapped,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    horizontalSpaceTiny,
                    Text(
                      'Create an account',
                      style: TextStyle(
                        color: ColorSettings.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            if (showTermsText)
              Text(
                'By signing up you agree to our terms, conditions and privacy policy.',
                textAlign: TextAlign.center,
              ),
            if (onGoogleButtonTapped != null || onAppleButtonTapped != null)
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Center(
                  child: Text("OR"),
                ),
              ),
            if (onGoogleButtonTapped != null)
              SignInButton(
                Buttons.Google,
                text: "SIGN IN WITH GOOGLE",
                onPressed: onGoogleButtonTapped!,
              ),
            if (onAppleButtonTapped != null)
              SignInButton(
                Buttons.Apple,
                text: "SIGN IN WITH APPLE",
                onPressed: onAppleButtonTapped!,
              ),
            verticalSpaceLarge,
            if (releaseName != null)
              Center(child: Text("Release - " + releaseName!)),
          ],
        ),
      ),
    );
  }
}
