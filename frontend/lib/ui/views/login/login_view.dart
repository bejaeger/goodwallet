import 'package:good_wallet/enums/authentication_method.dart';
import 'package:good_wallet/ui/layout_widgets/authentication_layout.dart';
import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import './login_viewmodel.dart';
import 'package:good_wallet/ui/views/login/login_view.form.dart';

@FormView(fields: [
  FormTextField(name: 'email'),
  FormTextField(name: 'password'),
])
class LoginView extends StatelessWidget with $LoginView {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
        body: AuthenticationLayout(
          busy: model.isBusy,
          onCreateAccountTapped: model.navigateToCreateAccount,
          onDummyLoginTapped: model.onDummyLoginTapped(),
          onMainButtonTapped: () => model.saveData(AuthenticationMethod.Email),
          validationMessage: model.validationMessage,
          title: 'Welcome to the \nGood Wallet',
          subtitle: 'The place that makes doing good simple',
          mainButtonTitle: 'SIGN IN',
          form: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        model.setIsPwShown(!model.isPwShown);
                      },
                      icon: (model.isPwShown)
                          ? Icon(Icons.visibility,
                              color: ColorSettings.primaryColor)
                          : Icon(Icons.visibility_off,
                              color: ColorSettings.primaryColor),
                    )),
                obscureText: (model.isPwShown) ? false : true,
                controller: passwordController,
              ),
              // with custom text
            ],
          ),
          onForgotPassword: () {},
          onGoogleButtonTapped: () =>
              model.saveData(AuthenticationMethod.google),
          releaseName: model.releaseName,
          // onFacebookButtonTapped: () =>
          //     model.runAuthentication(AuthenticationMethod.facebook),
          // onAppleButtonTapped: () =>
          //     model.runAuthentication(AuthenticationMethod.apple),
        ),
      ),
    );
  }
}






/*

const Color darkColor = Color(0xBB353531);
const Color redColor = Color(0xFFCF3D31);
const Color mainColor = ColorSettings.primaryColor;

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      //onModelReady: (model) => model.navigateToWalletView(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          //model.setShowNavigationBar(true);
          model.navigateToWalletView();
          return true;
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: ListView(
            children: [
              CenteredView(
                maxWidth: 500.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: model.isBusy
                      ? LinearProgressIndicator()
                      : Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 2,
                          child: Container(
                            height: 700, // 25 = safearea
                            child: buildAuthScreenContent(context, model),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack buildAuthScreenContent(BuildContext context, dynamic model) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Spacer(flex: 2),
              Container(
                height: 120,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/vacuum.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Good Wallet",
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              AuthCard(model: model),
              Spacer(flex: 3),
              Container(
                constraints: BoxConstraints(maxWidth: 60),
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/btn_google_signin_light_normal_web.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                child: InkWell(
                  onTap: () async => await model.loginWithGoogle(),
                ),
              ),
              Spacer(flex: 3),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                              title: Text("Privacy Consent"),
                              content: Text("Privacy Consent"),
                            );
                          }),
                      child: Text(
                        "Privacy Consent",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: darkColor.withOpacity(0.3)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Terms & Conditions"),
                              content: Text("Terms & Conditions"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          }),
                      child: Text(
                        "Terms & Conditions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: darkColor.withOpacity(0.3)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: redColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            boxShadow: model.hasError
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.topCenter,
          height: model.hasError ? 60 : 0,
          child: Center(
            child: Text(
              model.errorMessage,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class AuthCard extends StatelessWidget {
  final dynamic model;

  AuthCard({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: model.formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.07),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            model.authMode == AuthMode.Signup
                ? MyTextField(
                    model: model,
                    labelText: 'Name',
                    icon: Icon(Icons.account_circle, color: mainColor),
                    validator: (value) {
                      if (value.isEmpty) {
                        model.setErrorMessage(true, 'Please specify a name');
                      }
                    },
                    onSaved: (value) {
                      model.setName(value);
                      //_authData['email'] = value;
                    },
                  )
                : Container(),
            SizedBox(height: 10),
            MyTextField(
              model: model,
              labelText: 'E-Mail',
              icon: Icon(Icons.email, color: mainColor),
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  model.setErrorMessage(true, 'Invalid email');
                }
              },
              onSaved: (value) {
                model.setEmail(value);
                //_authData['email'] = value;
              },
            ),
            SizedBox(height: 10),
            MyTextField(
              model: model,
              suffixIcon: (model.authMode == AuthMode.Login)
                  ? IconButton(
                      onPressed: () {
                        model.setIsPwShown(!model.isPwShown);
                      },
                      icon: (model.isPwShown)
                          ? Icon(Icons.visibility, color: mainColor)
                          : Icon(Icons.visibility_off, color: mainColor),
                    )
                  : null,
              labelText: 'Password',
              icon: Icon(Icons.vpn_key, color: mainColor),
              obscureText: (model.isPwShown) ? false : true,
              validator: (value) {
                if (value.isEmpty || value.length < 5) {
                  model.setErrorMessage(true, 'Password is too short!');
                }
              },
              onSaved: (value) {
                model.setPassword(value);
              },
            ),
            Container(
              height: 20,
            ),
            Container(
              height: 42,
              child: RaisedButton(
                elevation: 4,
                child: Text(
                  model.authMode == AuthMode.Login ? 'Login' : 'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  model.submit();
                  model.navigateToWalletView();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ),
            verticalSpaceSmall,
            Container(
              height: 42,
              child: RaisedButton(
                elevation: 4,
                child: Text(
                  'Login Hans',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  model.dummyLoginHans();
                  // model.submit();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () => model.switchAuthMode(),
                  child: Text(
                    '${model.authMode == AuthMode.Login ? 'Sign up' : 'Login'}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: mainColor),
                  ),
                ),
                Container(
                  child: Text(
                    "Forgot Password?",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800].withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final dynamic model;
  final Function validator;
  final Function onSaved;
  final Icon icon;
  final String labelText;
  final IconButton suffixIcon;
  final bool obscureText;

  const MyTextField(
      {Key key,
      @required this.model,
      @required this.validator,
      @required this.onSaved,
      @required this.icon,
      @required this.labelText,
      this.suffixIcon,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 48,
          margin: EdgeInsets.only(left: 3, right: 3),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: TextFormField(
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.only(top: 0),
              icon: icon,
              labelText: labelText,
              labelStyle: TextStyle(
                color: darkColor.withOpacity(0.3),
              ),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: validator,
            onSaved: onSaved,
            obscureText: obscureText,
          ),
        ),
      ],
    );
  }
}
*/