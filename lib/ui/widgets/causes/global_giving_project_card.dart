import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/widgets/call_to_action_button.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

// Widget to preview global giving projects

class GlobalGivingProjectCardMobile extends StatelessWidget {
  final Project project;
  final void Function()? onTap;
  final void Function()? onTapFavorite;
  final bool displayArea;

  GlobalGivingProjectCardMobile(
      {required this.project,
      this.onTap,
      this.onTapFavorite,
      this.displayArea = false});
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
                      MyColors.black54.withOpacity(0.4)
                    ],
                  ),
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
              if (onTapFavorite != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border,
                        size: 22, color: ColorSettings.whiteTextColor),
                    onPressed: onTapFavorite,
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

class GlobalGivingProjectCard extends StatelessWidget {
  final Project? project;
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
                onPressed: onTapFavorite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
