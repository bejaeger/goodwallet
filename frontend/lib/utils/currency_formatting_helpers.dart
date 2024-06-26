import 'package:good_wallet/utils/logger.dart';
import 'package:good_wallet/utils/other_helpers.dart';
import 'package:intl/intl.dart';

final log = getLogger("currency_formating_service.dart");

// deal with locale at some other point
final String defaultLocale = "en-US";

// Use this to display amount in UI
//
// In firestore we store currencies multiplied by 100
// so we need to divide them by 100 again
// (if they are non-zero-decimal currencies)
String formatAmount(amount,
    {bool userInput = false,
    bool showDollarSign = true,
    bool showDecimals = true}) {
  num returnAmount = (isNonZeroDecimalCurrency() && userInput == false)
      ? (amount / 100)
      : amount;
  var returnValue =
      NumberFormat.simpleCurrency(locale: defaultLocale).format(returnAmount);
  if (!showDollarSign) returnValue = returnValue.replaceAll("\$", "");
  if (!showDecimals && isNonZeroDecimalCurrency())
    returnValue = removeLastCharacters(returnValue, removeNumber: 3);
  return returnValue;
}

// Format amount for stripe that takes it in cents
num scaleAmountForStripe(num amount) {
  num returnAmount =
      isNonZeroDecimalCurrency() ? (amount * 100).round() : amount.round();
  return returnAmount;
}

// There are currencies without decimals, check for this
bool isNonZeroDecimalCurrency() {
  try {
    var numberFormat = NumberFormat.simpleCurrency(locale: defaultLocale);
    return numberFormat.decimalDigits != 0;
  } catch (e) {
    log.e("Potentially an invalid locale was parsed to isNonDecimalCurrency()");
    rethrow;
  }
}
