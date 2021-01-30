import 'package:flutter/material.dart';
import 'package:good_wallet/app/locator.dart';
import 'package:good_wallet/app/router.gr.dart';
import 'package:good_wallet/style/colors.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:good_wallet/viewmodels/home/welcome_view_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService _navigationService = locator<NavigationService>();
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: CenteredView(
            maxWidth: MediaQuery.of(context).size.width > 1000
                ? 1000
                : MediaQuery.of(context).size.width / 1.1,
            child: ListView(
              controller: model.scrollController,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: AutoScrollTag(
                      key: ValueKey(0),
                      controller: model.scrollController,
                      index: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to the',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                height: 0.9,
                                fontSize: 40),
                          ),
                          Text(
                            'GOOD WALLET',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                height: 0.9,
                                fontSize: 60),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Earn money and spend it on good causes.',
                            style: TextStyle(
                              fontSize: 21,
                              height: 1.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                verticalSpace(50),
                FlatButton(
                  onPressed: () => model.jumpToGraphic(),
                  child: Text("Are you interested in our vision? Click here!"),
                ),
                verticalSpace(600),
                AutoScrollTag(
                  key: ValueKey(1),
                  controller: model.scrollController,
                  index: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: [
                        Text(
                          "Our Vision! Explained in an awesome graphic",
                          style: TextStyle(fontSize: 30),
                        ),                        
                        verticalSpace(40),
                        Card(
                          child: Container(
                            height: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/our-vision-graphic.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(40),
                        Card(
                          child: Container(
                            height: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/concept-text.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),                        
                      ],
                    ),
                  ),
                ),
                verticalSpace(500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
