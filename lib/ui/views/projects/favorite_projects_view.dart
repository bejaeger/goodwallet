import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/layout_widgets/list_of_projects_layout.dart';
import 'package:good_wallet/ui/views/projects/projects_for_area_viewmodel.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class FavoriteProjectsView extends StatelessWidget {
  final List<Project> projects;
  const FavoriteProjectsView({Key? key, required this.projects})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectsForAreaViewModel>.reactive(
        viewModelBuilder: () => ProjectsForAreaViewModel(projects: projects),
        builder: (context, model, child) {
          return ConstrainedWidthWithScaffoldLayout(
            child: CustomScrollView(
              key: PageStorageKey('storage-key'),
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
                CustomSliverAppBarSmall(
                  title: "Favorite Projects",
                ),
                projects.length == 0
                    ? SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: screenHeightPercentage(context,
                                  percentage: 0.2),
                            ),
                            Text("+ Add New Favorite",
                                style: textTheme(context).headline6),
                          ],
                        ),
                      )
                    : ListOfProjectsLayout(
                        projects: model.projects,
                        isBusy: model.isBusy,
                        showNotImplementedNotification:
                            model.showNotImplementedSnackbar,
                        onProjectTapped: model.navigateToSingleProjectScreen,
                        onFavoriteTapped: model.addOrRemoveFavorite,
                        isFavorite: model.isFavoriteProject,
                      ),
              ],
            ),
          );
        });
  }
}
