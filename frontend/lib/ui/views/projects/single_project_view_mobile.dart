import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/projects/single_project_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header_image.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/ui/widgets/money_pool_sliver_app_bar.dart';
import 'package:good_wallet/ui/widgets/project_sliver_app_bar.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stacked/stacked.dart';

// view showing single project
// If only projectId is supplied, data will be fetched
// Otherwise no need to fetch data.

class SingleProjectViewMobile extends StatelessWidget {
  final String projectId;
  const SingleProjectViewMobile({Key? key, required this.projectId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleProjectViewModel>.reactive(
      viewModelBuilder: () => SingleProjectViewModel(projectId: projectId),
      onModelReady: (model) => model.initProject(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: model.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                //key: PageStorageKey('storage-key'),
                physics: ScrollPhysics(),
                slivers: [
                  ProjectSliverAppBar(
                    title: model.project!.name,
                    organizationName: model.project!.organization!.name,
                    onRightIconPressed: () =>
                        model.addOrRemoveFavorite(projectId),
                    isFavoriteProject: model.isFavoriteProject(projectId),
                    backgroundImageUrl: model.project!.imageUrl!,
                    onDonateButtonPressed: () =>
                        model.navigateToTransferFundAmountView(model.project!),
                    onTopLeftIconPressed: model.navigateBack,
                    //       fit: BoxFit.cover),
                  ),

                  // AlternativeScreenHeaderImage(
                  //   backgroundWidget: Image.network(model.project!.imageUrl!,
                  //       fit: BoxFit.cover),
                  //   title: model.project!.name,
                  //   onTopLeftButtonPressed: model.navigateBack,
                  //   topRightWidget: IconButton(
                  //     icon: Icon(
                  //         model.isFavoriteProject(projectId)
                  //             ? Icons.favorite
                  //             : Icons.favorite_border,
                  //         size: 25,
                  //         color: model.isFavoriteProject(projectId)
                  //             ? ColorSettings.primaryColorDark
                  //             : ColorSettings.whiteTextColor),
                  //     onPressed: () => model.addOrRemoveFavorite(projectId),
                  //   ),
                  // ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: LayoutSettings.horizontalPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("By ${model.project!.organization!.name}"),
                              // Text(
                              //   model.project!.organization!.url,
                              //   softWrap: true,
                              // ),
                              verticalSpaceMedium,
                              Text(
                                model.project!.name,
                                textAlign: TextAlign.center,
                                style: textTheme(context).headline4!,
                                //maxLines: 2,
                                //overflow: TextOverflow.ellipsis,
                              ),
                              // Text(
                              //   model.project!.organization!.name,
                              //   softWrap: true,
                              //   style: textTheme(context).headline6,
                              // ),
                              verticalSpaceMedium,
                              Text(
                                model.project!.summary!,
                                softWrap: true,
                              ),
                              verticalSpaceMedium,
                              Text(
                                model.project!.organization!.url,
                                softWrap: true,
                              ),
                              if (model.getFundingPercentage() != null)
                                verticalSpaceMedium,
                              if (model.getFundingPercentage() != null)
                                FundingStatusProgressBar(
                                  fundingCurrent:
                                      model.project!.fundingCurrent!,
                                  fundingGoal: model.project!.fundingGoal!,
                                  fundingPercentage:
                                      model.getFundingPercentage()!,
                                ),
                            ],
                          ),
                        ),
                        verticalSpaceMassive,
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class FundingStatusProgressBar extends StatelessWidget {
  final num fundingCurrent;
  final num fundingGoal;
  final double fundingPercentage;

  const FundingStatusProgressBar({
    Key? key,
    required this.fundingCurrent,
    required this.fundingGoal,
    required this.fundingPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearPercentIndicator(
          animationDuration: 0,
          backgroundColor: MyColors.paletteBlue.withOpacity(0.2),
          lineHeight: 30.0,
          // center: Text("$fundingPercentage \%",
          //     style: TextStyle(color: Colors.white)),
          animation: true,
          percent: fundingPercentage / 100,
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: ColorSettings.primaryColor.withOpacity(0.8),
        ),
        verticalSpaceTiny,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    formatAmount(fundingCurrent,
                        userInput: true, showDecimals: false),
                    style: textTheme(context).headline6),
                Text("Current funding"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    formatAmount(fundingGoal,
                        userInput: true, showDecimals: false),
                    style: textTheme(context).headline6),
                Text("Funding goal"),
              ],
            ),
          ],
        )
      ],
    );
  }
}
