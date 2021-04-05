import 'package:flutter/material.dart';
import 'package:good_wallet/ui/views/home/welcome_viewmodel.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:stacked/stacked.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      onModelReady: (model) {
        model.imageHeight = MediaQuery.of(context).size.height;
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: NotificationListener<ScrollNotification>(
            onNotification: model.handleScrollNotification,
            child: Stack(
              children: [
                Positioned(
                  top: -0.3 * model.currentOffset,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/hand-throwing-dice-on-yellow.jpg",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: model.imageHeight,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0, left: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome to the',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[850],
                                  height: 0.9,
                                  fontSize: 40),
                            ),
                            Text(
                              'GOOD WALLET',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  height: 0.9,
                                  color: Colors.grey[850],
                                  fontSize: 60),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ListView(
                  controller: model.scrollController,
                  cacheExtent: 100.0,
                  addAutomaticKeepAlives: false,
                  children: <Widget>[
                    SizedBox(
                      height: model.imageHeight,
                    ),
                    AutoScrollTag(
                      key: ValueKey(1),
                      controller: model.scrollController,
                      index: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: [
                            Container(
                              height: 800,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey[50],
                              child: Padding(
                                padding: const EdgeInsets.all(60.0),
                                child: Text("Our Vision",
                                    style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.w800)),
                              ),
                            ),
                            Container(
                              height: 800,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey[50],
                              child: Padding(
                                padding: const EdgeInsets.all(60.0),
                                child: Text("Join Us",
                                    style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.w800)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
