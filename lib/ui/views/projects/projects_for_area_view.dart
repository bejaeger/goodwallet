import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/layout_widgets/list_of_projects_layout.dart';
import 'package:good_wallet/ui/views/projects/projects_for_area_viewmodel.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:stacked/stacked.dart';

class ProjectsForAreaView extends StatelessWidget {
  final String area;

  const ProjectsForAreaView({Key? key, required this.area}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectsForAreaViewModel>.reactive(
        viewModelBuilder: () => ProjectsForAreaViewModel(area: area),
        builder: (context, model, child) {
          return ConstrainedWidthWithScaffoldLayout(
            child: CustomScrollView(
              key: PageStorageKey('storage-key'),
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
                CustomSliverAppBarSmall(
                  title: area,
                ),
                ListOfProjectsLayout(
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
