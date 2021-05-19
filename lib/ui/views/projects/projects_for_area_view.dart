import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/projects/projects_for_area_viewmodel.dart';
import 'package:good_wallet/ui/widgets/causes/global_giving_project_card.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

class ProjectsForAreaView extends StatelessWidget {
  final List<Project> projects;
  final String area;

  const ProjectsForAreaView(
      {Key? key, required this.projects, required this.area})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectsForAreaViewModel>.reactive(
      viewModelBuilder: () => ProjectsForAreaViewModel(projects: projects),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        child: CustomScrollView(
          key: PageStorageKey('storage-key'),
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            CustomSliverAppBarSmall(
              title: area,
            ),
            model.isBusy
                ? SliverToBoxAdapter(
                    child: Center(child: LinearProgressIndicator()))
                : SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          children: [
                            verticalSpaceRegular,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: LayoutSettings.horizontalPadding),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: model.projects.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GlobalGivingProjectCardMobile(
                                    showDescription:
                                        model.projects[index].causeType ==
                                                CauseType.GoodWalletFund
                                            ? true
                                            : false,
                                    project: model.projects[index],
                                    onTap: model.projects[index].causeType ==
                                            CauseType.GoodWalletFund
                                        ? model.showNotImplementedSnackbar
                                        : () =>
                                            model.navigateToSingleProjectScreen(
                                                index),
                                    onTapFavorite:
                                        model.showNotImplementedSnackbar,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
