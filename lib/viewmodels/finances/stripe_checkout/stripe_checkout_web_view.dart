@JS()
library stripe;

import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'dart:html';

const apiKey =
    'pk_test_51HsIjGKMG1WPogVfkBOAiW59LeE9tjOleUdOAShJjTavXqj16ionV9t3pJrhzSML1UDEqQ0xqfNYKLxlqC3J9Jvq00Mm2DkWjz';
const vacuumPriceId = 'price_1I7PYZKMG1WPogVf9YbqU0Xj';

Future redirectToCheckout(String sessionId) async {
  final stripe = Stripe(apiKey);
  var url = window.location.href;
  print("INFO: Current URL $url");
  await stripe.redirectToCheckout(CheckoutOptions(sessionId: sessionId)).then(
    (result) {
      print("In checkout session");
      // If `redirectToCheckout` fails due to a browser or network
      // error, you should display the localized error message to your
      // customer using `error.message`.
      if (result.error) {
        print(result.error.message);
      }
    },
  );
  print("INFO: Returning from function!");
  // check if this url is success or not!
  var afterurl = window.location.href;
  print("INF: url when returning is ${afterurl}");
}

@JS()
class Stripe {
  external Stripe(String key);
  external redirectToCheckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external List<LineItem> get lineItems;

  external String get mode;

  external String get successUrl;

  external String get cancelUrl;

  external factory CheckoutOptions({
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancelUrl,
    String sessionId,
  });
}

@JS()
@anonymous
class LineItem {
  external String get price;

  external int get quantity;

  external factory LineItem({String price, int quantity});
}
