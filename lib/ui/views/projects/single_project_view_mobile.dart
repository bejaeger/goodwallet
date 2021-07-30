import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/projects/single_project_viewmodel.dart';
import 'package:good_wallet/ui/widgets/alternative_screen_header_image.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
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
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  AlternativeScreenHeaderImage(
                    backgroundWidget: Image.network(model.project!.imageUrl!,
                        fit: BoxFit.cover),
                    title: model.project!.name,
                    onTopLeftButtonPressed: model.navigateBack,
                    topRightWidget: IconButton(
                      icon: Icon(
                          model.isFavoriteProject(projectId)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 25,
                          color: model.isFavoriteProject(projectId)
                              ? ColorSettings.primaryColorDark
                              : ColorSettings.whiteTextColor),
                      onPressed: () => model.addOrRemoveFavorite(projectId),
                    ),
                  ),
                  Column(
                    children: [
                      verticalSpaceRegular,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: LayoutSettings.horizontalPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CallToActionButtonRectangular(
                                maxWidth: screenWidthPercentage(context,
                                    percentage: 0.45),
                                color: ColorSettings.primaryColor,
                                title: "Donate",
                                onPressed: () =>
                                    model.navigateToTransferFundAmountView(
                                        model.project!)),
                          ],
                        ),
                      ),
                      verticalSpaceMedium,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: LayoutSettings.horizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.project!.organization!.name,
                              softWrap: true,
                              style: textTheme(context).headline6,
                            ),
                            Text(
                              model.project!.organization!.url,
                              softWrap: true,
                            ),
                            verticalSpaceMedium,
                            Text(
                              model.project!.summary!,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
