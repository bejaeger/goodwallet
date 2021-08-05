import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/datamodels/user/statistics/supported_project_statistics.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

// Widget to preview global giving projects

class GlobalGivingProjectCardMobile extends StatelessWidget {
  final Project project;
  final void Function()? onTap;
  final void Function()? onFavoriteTapped;
  final bool isFavorite;
  final bool displayArea;
  final bool showDescription;

  GlobalGivingProjectCardMobile(
      {required this.project,
      this.onTap,
      this.onFavoriteTapped,
      this.displayArea = false,
      this.isFavorite = false,
      this.showDescription = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          //width: screenWidthPercentage(context, percentage: 0.8),
          height: 150,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (project.imageUrl != null)
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.transparent,
                          MyColors.black87.withOpacity(0.5)
                        ],
                      ),
                      image: DecorationImage(
                        image: project.causeType ==
                                CauseType.GlobalGivingProject
                            ? NetworkImage(project.imageUrl!) as ImageProvider
                            : AssetImage(project.imageUrl!) as ImageProvider,
                        fit: BoxFit.cover,
                      )),
                ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    //stops: [0.0, 1.0],
                    colors: [
                      Colors.transparent,
                      MyColors.black54.withOpacity(0.4)
                    ],
                  ),
                ),
              ),
              if (showDescription && project.summary != null)
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: screenWidth(context, percentage: 0.7),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(project.summary!,
                            style: textTheme(context).bodyText1!.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w600))),
                  ),
                ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      size: 22, color: ColorSettings.whiteTextColor),
                ),
              ),
              if (onFavoriteTapped != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        size: 25,
                        color: isFavorite
                            ? ColorSettings.primaryColorDark
                            : ColorSettings.whiteTextColor),
                    onPressed: onFavoriteTapped,
                  ),
                ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                  child: SizedBox(
                    width: screenWidthWithoutPadding(context, percentage: 0.7),
                    child: Text(
                      displayArea ? project.area : project.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme(context).headline5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlobalGivingProjectCardWithFunding extends StatelessWidget {
  final SupportedProjectStatistics project;
  final void Function()? onTap;
  final void Function()? onFavoriteTapped;
  final bool isFavorite;
  final bool displayArea;
  final bool showDescription;
  final num totalDonated;

  GlobalGivingProjectCardWithFunding(
      {required this.project,
      this.onTap,
      this.onFavoriteTapped,
      this.displayArea = false,
      this.isFavorite = false,
      this.showDescription = false,
      required this.totalDonated});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          //width: screenWidthPercentage(context, percentage: 0.8),
          height: 150,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (project.projectInfo.imagePath != null)
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.transparent,
                          MyColors.black87.withOpacity(0.5)
                        ],
                      ),
                      image: DecorationImage(
                        image: NetworkImage(project.projectInfo.imagePath!)
                            as ImageProvider,
                        fit: BoxFit.cover,
                      )),
                ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    //stops: [0.0, 1.0],
                    colors: [
                      MyColors.black54.withOpacity(0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: SizedBox(
                    width: screenWidthWithoutPadding(context, percentage: 0.7),
                    child: Text(
                      displayArea
                          ? project.projectInfo.area
                          : project.projectInfo.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          textTheme(context).headline5!.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: ColorSettings.primaryColor.withOpacity(0.8),
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          horizontalSpaceSmall,
                          Text("Supported: ",
                              style: textTheme(context).bodyText1),
                          Text(formatAmount(totalDonated),
                              style: textTheme(context).bodyText1),
                          horizontalSpaceSmall,
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlobalGivingProjectCard extends StatelessWidget {
  final Project? project;
  final void Function()? onTap;
  final void Function()? onFavoriteTapped;

  GlobalGivingProjectCard(
      {required this.project, this.onTap, this.onFavoriteTapped});
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(project!.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(project!.name,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600)),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              CallToActionButtonSimple(
                color: ColorSettings.primaryColor,
                onTap: onTap,
                text: "Give",
                //icon: Icon(Icons.arrow_circle_up, color: ATLASred),
              ),
              // FlatButton(
              //   textColor: ATLASred,
              //   onPressed: () {
              //     // Perform some action
              //   },
              //   child:
              //   Text("Give"),
              // ),
              IconButton(
                icon: Icon(Icons.favorite, color: ColorSettings.primaryColor),
                onPressed: onFavoriteTapped,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
