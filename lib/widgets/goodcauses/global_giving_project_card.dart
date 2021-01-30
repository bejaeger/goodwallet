import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/goodcauses/global_giving_project_model.dart';
import 'package:good_wallet/style/colors.dart';
import 'package:good_wallet/views/wallet/wallet_view.dart';

class GlobalGivingProjectCard extends StatelessWidget {
  final GlobalGivingProjectModel project;
  final Function onTap;

  GlobalGivingProjectCard({@required this.project, this.onTap});
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
                image: NetworkImage(project.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(project.title,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600)),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              CallToActionButton(
                color: ATLASred,
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
                icon: Icon(Icons.favorite, color: ATLASred),
                onPressed: () {
                  // Perform some action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
