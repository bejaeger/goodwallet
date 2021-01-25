import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_wallet/viewmodels/payments/stripe_checkout/stripe_checkout_mobile_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

///These keys are revoked. Use keys and product ids from Stripe dashboard.
const apiKey =
    'pk_test_51HsIjGKMG1WPogVfkBOAiW59LeE9tjOleUdOAShJjTavXqj16ionV9t3pJrhzSML1UDEqQ0xqfNYKLxlqC3J9Jvq00Mm2DkWjz';
const initialUrl = 'https://marcinusx.github.io/test1/index.html';

class StripeCheckoutMobileView extends StatefulWidget {
  final String sessionId;

  const StripeCheckoutMobileView({Key key, this.sessionId}) : super(key: key);

  @override
  _StripeCheckoutMobileViewState createState() =>
      _StripeCheckoutMobileViewState();
}

class _StripeCheckoutMobileViewState extends State<StripeCheckoutMobileView> {
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StripeCheckoutMobileViewModel>.reactive(
      viewModelBuilder: () => StripeCheckoutMobileViewModel(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: WebView(
            initialUrl: initialUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (webViewController) =>
                _webViewController = webViewController,
            onPageFinished: (String url) {
              if (url == initialUrl) {
                _redirectToStripe(widget.sessionId);
              }
            },
            navigationDelegate: (NavigationRequest request) async {
              if (request.url.startsWith('https://example.com/success')) {
                await model.showSuccessDialog();
              } else if (request.url.startsWith('https://example.com/cancel')) {
                await model.showDeniedDialog();
              }
              return NavigationDecision.navigate;
            },
          ),
        ),
      ),
    );
  }

  Future<void> _redirectToStripe(String sessionId) async {
    final redirectToCheckoutJs = '''
var stripe = Stripe(\'$apiKey\');
stripe.redirectToCheckout({
  sessionId: '$sessionId'
}).then(function (result) {
  result.error.message = 'Error'
});
''';
    try {
      await _webViewController.evaluateJavascript(redirectToCheckoutJs);
    } on PlatformException catch (e) {
      if (!e.details.contains(
          'JavaScript execution returned a result of an unsupported type')) {
        rethrow;
      }
    }
  }
}
