import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/projects/projects_viewmodel.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';
import 'package:good_wallet/ui/widgets/causes/global_giving_project_card.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/search_text_field.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/ui/widgets/small_wallet_card.dart';
import 'package:good_wallet/utils/currency_formatting_helpers.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectsViewModel>.reactive(
      viewModelBuilder: () => ProjectsViewModel(),
      onModelReady: (model) async => await model.listenToData(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: RefreshIndicator(
          onRefresh: () async => await model.refresh(),
          child: CustomScrollView(
            key: PageStorageKey('storage-key'),
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomSliverAppBarSmall(
                forceElevated: false,
                title: "Social Projects",
                onRightIconPressed: model.navigateToFavoritesView,
                rightIcon: Icon(Icons.favorite_border_rounded,
                    color: ColorSettings.pageTitleColor, size: 28),

                // show little wallet
                // onSecondRightIconPressed: model.showNotImplementedSnackbar,
                // secondRightIcon: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Icon(Icons.account_balance_wallet,
                //         color: ColorSettings.blackTextColor),
                //     Text(
                //       formatAmount(model.userStats.currentBalance),
                //       style: textTheme(context)
                //           .bodyText2!
                //           .copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                //     ),
                //   ],
                // ),

                // Temporarily allow DAN to push new projects to firebase
                // onSecondRightIconPressed: model.navigateToProfileView,
                // secondRightIcon: Icon(
                //   Icons.person,
                //   color: ColorSettings.pageTitleColor,
                //   size: 28,
                // ),
                // onSecondRightIconPressed:
                //     model.currentUser.uid == "ptWSWNPX4xRyVsb6jwjPfff5C2B3"
                //         ? model.pushGlobalGivingProjectsToFirestore
                //         : null,
                // secondRightIcon: Icon(Icons.plus_one, size: 28),
              ),
              SliverToBoxAdapter(
                child: GreySearchTextField(hintText: "Search Projects"),
              ),
              model.isBusy
                  ? SliverToBoxAdapter(
                      child: Center(
                          child: Column(
                      children: [
                        verticalSpaceSmall,
                        CircularProgressIndicator(),
                      ],
                    )))
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          verticalSpaceSmall,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionHeader(title: "User Top Picks"),
                              verticalSpaceTiny,
                              ProjectsTopPicksCarousel(
                                  projects: model.projectTopPicks,
                                  onPressed:
                                      model.navigateToSingleProjectScreen),
                              verticalSpaceRegular,
                              SectionHeader(title: "All Areas"),
                              verticalSpaceTiny,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        LayoutSettings.horizontalPadding),
                                child: GridView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount:
                                      model.projectUniqueAreas.length + 1,
                                  itemBuilder: (context, index) {
                                    late Project data;
                                    if (index == 0) {
                                      data =
                                          model.getGoodWalletFundsInfo()[index];
                                    } else {
                                      data =
                                          model.projectUniqueAreas[index - 1];
                                    }
                                    return GlobalGivingProjectCardMobile(
                                      displayArea: true,
                                      project: data,
                                      onTap: () =>
                                          model.navigateToProjectForAreaView(
                                              area: data.area),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          verticalSpaceLarge,
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

class ProjectsTopPicksCarousel extends StatelessWidget {
  final List<Project>? projects;
  final void Function(String) onPressed;

  const ProjectsTopPicksCarousel(
      {Key? key, required this.projects, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return projects == null
        ? SizedBox(height: 0)
        : SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: projects!.length,
              itemBuilder: (context, index) {
                final project = projects![index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: LayoutSettings.horizontalPadding),
                  child: CarouselCard(
                    title: project.organization?.name ?? project.name,
                    explanation: project.name,
                    explanationAlignment: Alignment.bottomLeft,
                    backgroundImage: project.imageUrl != null
                        ? NetworkImage(project.imageUrl!)
                        : null,
                    onTap: () => onPressed(project.id),
                  ),
                );
              },
            ),
          );
  }
}
