import 'package:flutter/material.dart';
import 'package:good_wallet/enums/featured_app_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/featured_applications/single_featured_app_viewmodel.dart';
import 'package:good_wallet/ui/views/home/home_custom_app_bar_view.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class SingleFeaturedAppView extends StatelessWidget {
  final FeaturedAppType type;

  const SingleFeaturedAppView({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleFeaturedAppViewModel>.reactive(
      viewModelBuilder: () => SingleFeaturedAppViewModel(),
      builder: (context, model, child) => Scaffold(
        body: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              bottom: PreferredSize(
                preferredSize: Size(screenWidth(context), 50),
                child: Padding(
                  padding:
                      const EdgeInsets.all(LayoutSettings.horizontalPadding),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Marketplace",
                        style: textTheme(context).headline3),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  ImagePath.marketPlaceImageURL,
                  fit: BoxFit.cover,
                ),
              ),
              pinned: true,
              floating: false,
              backgroundColor: MyColors.paletteBlue,
              expandedHeight: 300,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: LayoutSettings.horizontalPadding),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpaceLarge,
                          Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15.0, left: 10.0),
                              width: screenWidthWithoutPadding(context) - 8.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Join our efforts and convert your unused items to donations",
                                      style: textTheme(context).headline6),
                                ],
                              ),
                            ),
                          ),
                          verticalSpaceMediumLarge,
                          SizedBox(height: 1000),
                        ],
                      ),
                      SizedBox(width: LayoutSettings.horizontalPadding),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
