import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/enums/causes_type.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/widgets/causes/global_giving_project_card.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

class ListOfProjectsLayout extends StatelessWidget {
  final List<Project> projects;
  final bool isBusy;
  final void Function() showNotImplementedNotification;
  final void Function(String projectId) onProjectTapped;
  final void Function(String projectId) onFavoriteTapped;
  final bool Function(String projectId) isFavorite;

  const ListOfProjectsLayout(
      {Key? key,
      required this.projects,
      required this.isBusy,
      required this.showNotImplementedNotification,
      required this.onProjectTapped,
      required this.onFavoriteTapped,
      required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isBusy
        ? SliverToBoxAdapter(child: Center(child: LinearProgressIndicator()))
        : SliverList(
            delegate: SliverChildListDelegate(
              [
                ConstrainedWidthLayout(
                  child: Column(
                    children: [
                      verticalSpaceRegular,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: LayoutSettings.horizontalPadding),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            Project project = projects[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GlobalGivingProjectCardMobile(
                                showDescription: project.causeType ==
                                        CauseType.GoodWalletFund
                                    ? true
                                    : false,
                                project: projects[index],
                                onTap: projects[index].causeType ==
                                        CauseType.GoodWalletFund
                                    ? showNotImplementedNotification
                                    : () => onProjectTapped(projects[index].id),
                                onFavoriteTapped: () =>
                                    onFavoriteTapped(project.id),
                                isFavorite: isFavorite(project.id),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
