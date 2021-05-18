import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/transfers/money_transfer.dart';
import 'package:good_wallet/ui/shared/money_transfers/transfer_history_entry_style.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class TransferListTile extends StatelessWidget {
  final num amount;
  final TransferHistoryEntryStyle style;
  final MoneyTransfer transaction;
  final bool showBottomDivider;
  final bool showTopDivider;
  final bool dense;

  const TransferListTile(
      {Key? key,
      required this.amount,
      required this.style,
      required this.transaction,
      this.showBottomDivider = true,
      this.showTopDivider = false,
      this.dense = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTopDivider == true)
          Divider(
            color: Colors.grey[500],
            thickness: 0.5,
          ),
        ListTile(
          visualDensity: VisualDensity.compact,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: CircleAvatar(
              backgroundColor: style.color.withOpacity(0.9), child: style.icon),
          // FlutterLogo(),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (style.descriptor != null)
                Text(
                  style.descriptor!,
                  style: textTheme(context).bodyText2!.copyWith(
                        fontSize: dense ? 13 : 15,
                      ),
                ),
              Text(style.nameToDisplay!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme(context).headline6!.copyWith(fontSize: 16)),
            ],
          ),
          // @see https://api.flutter.dev/flutter/intl/DateFormat-class.html
          //.add_jm()
          subtitle: Text(
            formatDate(transaction.createdAt.toDate()),
            style: textTheme(context).bodyText2!.copyWith(
                  fontSize: dense ? 13 : 15,
                ),
          ),
          trailing:
              Text(formatAmount(amount), style: TextStyle(color: style.color)),
        ),
        if (showBottomDivider == true)
          Divider(
            color: Colors.grey[500],
            thickness: 0.5,
          ),
      ],
    );
  }
}
