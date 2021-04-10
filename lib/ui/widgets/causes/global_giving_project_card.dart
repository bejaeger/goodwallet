import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/global_giving_project_model.dart';
import 'package:good_wallet/datamodels/causes/good_wallet_project_model.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/ui/widgets/pledge_button.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

// Widget to preview global giving projects

class GlobalGivingProjectCardMobile extends StatelessWidget {
  final GoodWalletProjectModel project;
  final void Function()? onTap;
  final void Function()? onTapFavorite;

  GlobalGivingProjectCardMobile(
      {required this.project, this.onTap, this.onTapFavorite});
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            //width: screenWidthPercentage(context, percentage: 0.8),
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
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
                        image: NetworkImage(project.imageUrl!),
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
                        MyColors.black54.withOpacity(0.6)
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border,
                        size: 25, color: MyColors.almostWhite),
                    onPressed: onTapFavorite,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 10,
                              child: Text(
                                project.title!,
                                style: textTheme(context).headline5,
                              ),
                            ),
                            Spacer(flex: 1),
                            Flexible(
                              flex: 3,
                              child:
                                  PledgeButton(title: "Give", onPressed: onTap),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GlobalGivingProjectCard extends StatelessWidget {
  final GoodWalletProjectModel? project;
  final void Function()? onTap;
  final void Function()? onTapFavorite;

  GlobalGivingProjectCard(
      {required this.project, this.onTap, this.onTapFavorite});
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
            child: Text(project!.title!,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600)),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              CallToActionButton(
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
                onPressed: onTapFavorite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
