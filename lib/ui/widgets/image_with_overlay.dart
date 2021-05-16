import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';

class ImageWithOverlay extends StatelessWidget {
  final String? imageUrl;
  final String? imagePath;

  const ImageWithOverlay({Key? key, this.imageUrl, this.imagePath})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.transparent, MyColors.black87.withOpacity(0.5)],
              ),
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : imagePath != null
                      ? DecorationImage(
                          image: AssetImage(imagePath!),
                          fit: BoxFit.cover,
                        )
                      : null),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              //stops: [0.0, 1.0],
              colors: [Colors.transparent, MyColors.black54.withOpacity(0.4)],
            ),
          ),
        ),
      ],
    );
  }
}
