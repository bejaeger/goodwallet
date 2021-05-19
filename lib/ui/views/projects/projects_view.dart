import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/projects/projects_viewmodel.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';
import 'package:good_wallet/ui/widgets/causes/global_giving_project_card.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/ui/widgets/section_header.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectsViewModel>.reactive(
      viewModelBuilder: () => ProjectsViewModel(),
      onModelReady: (model) => model.listenToProjects(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: RefreshIndicator(
          onRefresh: () async => await model.refresh(),
          child: CustomScrollView(
            key: PageStorageKey('storage-key'),
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              CustomSliverAppBarSmall(
                title: "Social Projects",
                onRightIconPressed: model.navigateToFavoritesView,
                rightIcon: Icon(Icons.favorite_border_rounded, size: 28),
                // Temporarily allow DAN to push new projects to firebase
                onSecondRightIconPressed: model.showNotImplementedSnackbar,
                secondRightIcon: Icon(Icons.search_rounded, size: 28),
                // onSecondRightIconPressed:
                //     model.currentUser.uid == "ptWSWNPX4xRyVsb6jwjPfff5C2B3"
                //         ? model.pushGlobalGivingProjectsToFirestore
                //         : null,
                // secondRightIcon: Icon(Icons.plus_one, size: 28),
              ),
              model.isBusy
                  ? SliverToBoxAdapter(
                      child: Center(child: LinearProgressIndicator()))
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          verticalSpaceMedium,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionHeader(title: "User Top Picks"),
                              verticalSpaceSmall,
                              ProjectsTopPicksCarousel(model: model),
                              verticalSpaceRegular,
                              SectionHeader(title: "All Areas"),
                              verticalSpaceSmall,
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
  final dynamic model;

  const ProjectsTopPicksCarousel({Key? key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 220,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "Rainforest Rescue",
              explanation: "Buy Back and Protect Forever Endangered Rainforest",
              explanationAlignment: Alignment.bottomLeft,
              backgroundImage: NetworkImage(
                  "https://www.globalgiving.org/pfil/9790/pict_grid7.jpg"),
              onTap: () => model.navigateToSingleProjectScreen(
                  projectName:
                      "Buy Back and Protect Forever Endangered Rainforest"),
              //
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "India COVID-19 Relief Fund",
              explanation: "GlobalGiving's relief fund for India",
              explanationAlignment: Alignment.bottomLeft,
              backgroundImage: NetworkImage(
                  "https://www.globalgiving.org/pfil/52192/pict_grid7.jpg"),
              onTap: () => model.navigateToSingleProjectScreen(
                  projectName: "India COVID-19 Relief Fund"),
              //
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
            CarouselCard(
              title: "The Nyaka AIDS Orphans Project",
              explanation: "High quality education for children in Uganda",
              explanationAlignment: Alignment.bottomLeft,
              backgroundImage: NetworkImage(
                  "https://www.globalgiving.org/pfil/898/pict_grid7.jpg"),
              onTap: () => model.navigateToSingleProjectScreen(
                  projectName: "High quality education for children in Uganda"),
              //
            ),
            SizedBox(width: LayoutSettings.horizontalPadding),
          ],
        ));
  }
}
