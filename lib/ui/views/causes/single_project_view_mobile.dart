import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_project_model.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/causes/single_project_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header_image.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

final _donationAmountController = TextEditingController();

class SingleProjectViewMobile extends StatelessWidget {
  final GoodWalletProjectModel? project;
  const SingleProjectViewMobile({Key? key, required this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleProjectViewModel>.reactive(
      viewModelBuilder: () => SingleProjectViewModel(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: ListView(
          children: <Widget>[
            AlternativeScreenHeaderImage(
              backgroundWidget:
                  Image.network(project!.imageUrl!, fit: BoxFit.cover),
              title: project!.title!,
              onTopLeftButtonPressed: model.navigateBack,
              topRightWidget: IconButton(
                icon: Icon(Icons.favorite_border,
                    size: 25, color: MyColors.almostWhite),
                onPressed: model.showNotImplementedSnackbar,
              ),
            ),
            verticalSpaceMedium,
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: LayoutSettings.horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: _donationAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefix: Text("\$ "),
                        suffix: Text("Amount "),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 5,
                    child: ElevatedButton(
                      onPressed: () =>
                          model.confirmationOrCancellationDistributor(
                              project!.title,
                              int.parse(_donationAmountController.text)),
                      child: Text('Donate'),
                    ),
                  ),
                  // Expanded(
                  //   child: ElevatedButton(
                  //       onPressed: () {
                  //         print('Surprise Motherfucker');
                  //       },
                  //       child: Text("Donate")),
                  // ),
                  // IconButton(
                  //   iconSize: 60.0,
                  //   onPressed: () {
                  //     print("Liked");
                  //   },
                  //   icon: Icon(
                  //     Icons.favorite_border,
                  //     color: Colors.red,
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: LayoutSettings.horizontalPadding),
                  child: Text(
                    "Balance: \$ " +
                        (model.userWallet.currentBalance! / 100).toString(),
                    style:
                        textTheme(context).bodyText2!.copyWith(fontSize: 16.0),
                  )),
            ),
            verticalSpaceMediumLarge,
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: LayoutSettings.horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project!.organization!.name!,
                    softWrap: true,
                    style: textTheme(context).headline6,
                  ),
                  Text(
                    project!.organization!.url!,
                    softWrap: true,
                  ),
                  verticalSpaceMedium,
                  Text(
                    project!.summary!,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
