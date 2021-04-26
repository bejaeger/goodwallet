import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/image_paths.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

// Carousel card to be used in carousels see e.g. home view

class CarouselCard extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final String? explanation;
  final Color backgroundColor;
  final Alignment? imageAlignment;
  final ImageProvider? backgroundImage;

  const CarouselCard(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.explanation,
      this.backgroundColor = MyColors.paletteBlue,
      this.imageAlignment,
      this.backgroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidthPercentage(context, percentage: 0.8),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 2.0,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        backgroundColor,
                        backgroundColor.withOpacity(0.7)
                      ],
                    ),
                    image: backgroundImage != null
                        ? DecorationImage(
                            image: backgroundImage!,
                            fit: BoxFit.cover,
                            alignment: imageAlignment ?? Alignment.center,
                          )
                        : null),
              ),
              if (backgroundImage != null)
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      //stops: [0.0, 1.0],
                      colors: [
                        MyColors.black87.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          width:
                              screenWidthPercentage(context, percentage: 0.55),
                          child: Text(explanation!,
                              style: textTheme(context)
                                  .bodyText1!
                                  .copyWith(fontSize: 16))),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.arrow_forward_ios,
                          color: ColorSettings.whiteTextColor, size: 20),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(title!, style: textTheme(context).headline5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
