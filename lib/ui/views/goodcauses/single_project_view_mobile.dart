import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/global_giving_project_model.dart';
import 'package:good_wallet/ui/views/causes/single_project_viewmodel.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

final _donationAmountController = TextEditingController();

class SingleProjectViewMobile extends StatelessWidget {
  final GlobalGivingProjectModel? project;
  const SingleProjectViewMobile({Key? key, required this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleProjectViewModel>.reactive(
      viewModelBuilder: () => SingleProjectViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(project!.title!),
          centerTitle: true,
        ),
        body: Container(
          // margin: EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  width: screenWidth(context),
                  // height: 100.0,
                  child: Image.network(
                    project!.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              verticalSpaceMedium,
              // Padding(
              //   padding: EdgeInsets.only(top: 20.0),
              // ),
              // Flexible(
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: _donationAmountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: '\$'),
                      ),
                    ),
                    Expanded(
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

              verticalSpaceMedium,
              Flexible(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(Icons.account_balance_wallet),
                          Text(
                            "\$ ${model.userWallet.currentBalance! / 100}",
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(Icons.support),
                          Text(
                            "\$ 0",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpaceMedium,
              // Container(
              //   child: Expanded(
              // Flexible()
              Text(
                project!.summary!,
                softWrap: true,
                style: TextStyle(),
              ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
