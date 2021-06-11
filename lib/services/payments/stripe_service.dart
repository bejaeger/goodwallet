import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:good_wallet/utils/logger.dart';

class StripeService {
  final log = getLogger('StripeService');

  Future<void> createPaymentMethod(
      {required String id,
      required String type,
      required BillingDetails billingDetails}) async {
    // create payment method
    final paymentMethod =
        await Stripe.instance.createPaymentMethod(PaymentMethodParams.card());
  }
}
