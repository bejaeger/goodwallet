import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';

class FeedCard extends StatelessWidget {
  final String title;
  final String actionButtonText;
  final String imageLocation;
  final String supportingText;

  const FeedCard(
      {Key key,
      this.title,
      this.actionButtonText,
      this.imageLocation,
      this.supportingText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageLocation),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(supportingText,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                textColor: MyColors.paletteBlue,
                onPressed: () {
                  // Perform some action
                },
                child: Text(actionButtonText),
              ),
              IconButton(
                icon: Icon(Icons.share),
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
