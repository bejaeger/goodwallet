import 'package:flutter/material.dart';
import 'package:good_wallet/enums/auth_mode.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:good_wallet/viewmodels/login/login_view_model.dart';
import 'package:stacked/stacked.dart';

const Color darkColor = Color(0xBB353531);
const Color redColor = Color(0xFFCF3D31);
const Color mainColor = Colors.blue;

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          //model.setShowNavigationBar(true);
          model.navigateToWalletView();
          return true;
        },
        child: Scaffold(
          body: CenteredView(
            maxWidth: 600,
            child: ListView(
              children: [
                Container(
                  height:
                      MediaQuery.of(context).size.height - 27, // 25 = safearea
                  child: buildAuthScreenContent(context, model),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack buildAuthScreenContent(BuildContext context, dynamic model) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Spacer(flex: 2),
            Container(
              height: 150,
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
            Spacer(
              flex: 3,
            ),
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
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: redColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
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

  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = new FocusNode();

  AuthCard({Key key, this.model}) : super(key: key);

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      print('Form data invalid!');
      return;
    }
    _formKey.currentState.save();
    model.setBusy(true);

    try {
      if (model.authMode == AuthMode.Login) {
        // Log user in
        await model.loginWithEmail(_authData['email'], _authData['password']);
      } else {
        // Sign user up
        await model.signUpWithEmail(_authData['email'], _authData['password']);
      }
      model.navigateToWalletView();
    } catch (error) {
      var errorMessage = 'Authentication failed.';
      if (error.message == 'EMAIL_EXISTS') {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'The email is not found';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      } else {
        errorMessage = 'Couldnt authenticate. Please try again later.';
      }
      model.setErrorMessage(true, errorMessage);
      model.setBusy(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // setError(bool hasError, String error) {
    //   _isLoading = false;
    //   Provider.of<Auth>(context, listen: false).setError(hasError, error);
    // }

    final deviceSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: deviceSize.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 48,
              child: Stack(
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
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        contentPadding: EdgeInsets.only(top: 0),
                        icon: Icon(Icons.account_circle, color: mainColor),
                        labelText: 'E-Mail',
                        labelStyle: TextStyle(
                          color: darkColor.withOpacity(0.3),
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          model.setErrorMessage(true, 'Invalid email');
                          print('Invalid email');
                          return '';
                        }
//                      setError(false, '');
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 48,
              child: Stack(
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
                            offset: Offset(1, 2)),
                      ],
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        contentPadding: EdgeInsets.only(top: 0),
                        suffixIcon: (model.authMode == AuthMode.Login)
                            ? IconButton(
                                onPressed: () {
                                  model.setIsPwShown(!model.isPwShown);
                                },
                                icon: (model.isPwShown)
                                    ? Icon(Icons.visibility, color: mainColor)
                                    : Icon(Icons.visibility_off,
                                        color: mainColor),
                              )
                            : null,
                        icon: Icon(Icons.vpn_key, color: mainColor),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: darkColor.withOpacity(0.3),
                        ),
                        border: InputBorder.none,
                      ),
                      obscureText: (model.isPwShown) ? false : true,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          model.setErrorMessage(true, 'Password is too short!');
                          print('Password is too short!');
                          return '';
                        }
//                      setError(false, '');
                        return null;
                      },
                      onSaved: (value) {
                        _authData['password'] = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: (model.authMode == AuthMode.Signup) ? 10 : 0),
            if (model.authMode == AuthMode.Signup)
              Stack(
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
                            offset: Offset(1, 2))
                      ],
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextFormField(
                      enabled: model.authMode == AuthMode.Signup,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        contentPadding: EdgeInsets.only(top: 0),
                        icon: Icon(Icons.vpn_key, color: mainColor),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          color: darkColor.withOpacity(0.3),
                        ),
                        border: InputBorder.none,
                      ),
                      obscureText: (model.isPwShown) ? false : true,
                      validator: model.authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                model.setErrorMessage(
                                    true, 'Passwords do not match!');
                                print('Passwords do not match!');
                                return '';
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            Container(
              height: 20,
            ),
            if (model.isBusy)
              Container(
                  height: 42, child: Center(child: CircularProgressIndicator()))
            else
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
                    _submit();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
