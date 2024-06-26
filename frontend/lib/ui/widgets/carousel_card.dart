import 'package:flutter/material.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:transparent_image/transparent_image.dart';

// Carousel card to be used in carousels see e.g. home view

class CarouselCard extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final String? explanation;
  final Color backgroundColor;
  final Alignment? imageAlignment;
  final Alignment explanationAlignment;
  final ImageProvider? backgroundImage;
  final String? backgroundImageUrl;

  const CarouselCard(
      {Key? key,
      required this.title,
      required this.onTap,
      this.explanation,
      this.backgroundColor = MyColors.paletteBlue,
      this.imageAlignment,
      this.explanationAlignment = Alignment.centerLeft,
      this.backgroundImage,
      this.backgroundImageUrl})
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
              if (backgroundImageUrl != null)
                FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: backgroundImageUrl!,
                    fit: BoxFit.cover),

              if (backgroundImageUrl == null)
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [backgroundColor, backgroundColor],
                      ),
                      image: backgroundImage != null
                          ? DecorationImage(
                              image: backgroundImage!,
                              fit: BoxFit.cover,
                              alignment: imageAlignment ?? Alignment.center,
                            )
                          : null),
                ),
              //if (backgroundImage != null)
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    //stops: [0.0, 1.0],
                    colors: [
                      MyColors.black87.withOpacity(0.4),
                      Colors.transparent,
                      MyColors.black87.withOpacity(0.4),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    if (explanation != null)
                      Align(
                        alignment: explanationAlignment,
                        child: SizedBox(
                            width: screenWidthPercentage(context,
                                percentage: 0.55),
                            child: Text(explanation!,
                                style: textTheme(context)
                                    .bodyText1!
                                    .copyWith(fontSize: 16))),
                      ),
                    Align(
                      alignment: Alignment.topRight,
                      child: onTap == null
                          ? null
                          : Icon(Icons.arrow_forward_ios,
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
