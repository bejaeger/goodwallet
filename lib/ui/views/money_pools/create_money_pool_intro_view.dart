import 'dart:math';
import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/money_pools/create_money_pool_intro_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class CreateMoneyPoolIntroView extends StatelessWidget {
  final _controller = PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  List<Widget> getPages(BuildContext context) {
    List<Widget> pages = [
      CreateMoneyPoolInfoPage(
        title: "Together we can make an impact",
        description:
            "Raise funds together as a group and freely choose how to distribute the money between users eventually.",
        backgroundColor: MyColors.lightRed.withOpacity(0.9),
      ),
      CreateMoneyPoolInfoPage(
        title: "Raise the stakes for your games!",
        description:
            "Leverage money pools for your next poker game, bets with friends, or collect funds as a prize to be won at your next beerpong tournament.",
        backgroundColor: MyColors.paletteTurquoise.withOpacity(0.9),
      ),
      CreateMoneyPoolInfoPage(
        title: "Challenge your friends!",
        description:
            "Be creative and make your friends add funds when pre-defined scenarios occur. For example, "
            "every time you do a workout, the others have to add money. ",
        backgroundColor: MyColors.palettePurple.withOpacity(0.9),
      ),
    ];
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateMoneyPoolIntroViewModel>.reactive(
      viewModelBuilder: () => CreateMoneyPoolIntroViewModel(),
      builder: (context, model, child) {
        List<Widget> _pages = getPages(context);
        return ConstrainedWidthWithScaffoldLayout(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: LayoutSettings.horizontalPadding),
            child: ListView(
              children: [
                AlternativeScreenHeader(
                  title: "Create a Money Pool",
                  onBackButtonPressed: model.navigateBack,
                  description:
                      "The easy way to raise money with friends and family",
                ),
                SizedBox(
                  height: screenHeightPercentage(context, percentage: 0.5),
                  child: Stack(
                    children: <Widget>[
                      PageView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _controller,
                        itemCount: _pages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _pages[index % _pages.length];
                        },
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: ColorSettings.greyTextColor!
                                  .withOpacity(0.4)),
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: DotsIndicator(
                              controller: _controller,
                              itemCount: _pages.length,
                              onPageSelected: (int page) {
                                _controller.animateToPage(
                                  page,
                                  duration: _kDuration,
                                  curve: _kCurve,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpaceLarge,
                Container(
                  constraints: BoxConstraints(
                    minWidth: screenWidthWithoutPadding(context),
                    maxWidth: screenWidthWithoutPadding(context),
                    minHeight: 45,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0.0),
                        elevation: 0.0,
                        primary:
                            ColorSettings.primaryColorLight.withOpacity(0.8)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 12.0, left: 20.0, right: 20.0),
                      child: Text(
                        "Start money pool",
                        style: textTheme(context).headline5!.copyWith(
                            fontSize: 18, color: ColorSettings.whiteTextColor),
                      ),
                    ),
                    onPressed: model.navigateToCreateMoneyPoolFormView,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CreateMoneyPoolInfoPage extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String description;

  const CreateMoneyPoolInfoPage(
      {Key? key,
      required this.title,
      required this.description,
      this.backgroundColor = MyColors.almostWhite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0), color: backgroundColor),
      constraints: const BoxConstraints.expand(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textTheme(context).headline3),
            verticalSpaceSmall,
            Text(description, style: textTheme(context).bodyText1),
          ],
        ),
      ),
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    this.color = Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 6.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2;

  // The distance between the center of each dot
  static const double _kDotSpacing = 20.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return Container(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: color,
          type: MaterialType.circle,
          child: Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

/*

class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  final List<Widget> _pages = <Widget>[
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(colors: Colors.blue),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(style: FlutterLogoStyle.stacked, colors: Colors.red),
    ),
    new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(style: FlutterLogoStyle.horizontal, colors: Colors.green),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new IconTheme(
        data: new IconThemeData(color: _kArrowColor),
        child: new Stack(
          children: <Widget>[
            new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
            new Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: new Container(
                color: Colors.grey[800].withOpacity(0.5),
                padding: const EdgeInsets.all(20.0),
                child: new Center(
                  child: new DotsIndicator(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageSelected: (int page) {
                      _controller.animateToPage(
                        page,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
*/
