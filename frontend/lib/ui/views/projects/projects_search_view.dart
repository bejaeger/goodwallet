import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/causes/project.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/layout_widgets/list_of_projects_layout.dart';
import 'package:good_wallet/ui/shared/color_settings.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/projects/projects_viewmodel.dart';
import 'package:good_wallet/ui/widgets/carousel_card.dart';
import 'package:good_wallet/ui/widgets/causes/global_giving_project_card.dart';
import 'package:good_wallet/ui/widgets/search_text_field.dart';
import 'package:good_wallet/utils/debouncer.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class ProjectsSearchView extends StatefulWidget {
  const ProjectsSearchView({Key? key}) : super(key: key);

  @override
  _ProjectsSearchViewState createState() => _ProjectsSearchViewState();
}

class _ProjectsSearchViewState extends State<ProjectsSearchView> {
  final _debouncer = Debouncer(milliseconds: 300);
  final textFieldFocusNode = FocusNode();
  final textFieldController = TextEditingController();
  List<Project> queryProjects = [];

  bool showSearchProjectsView = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProjectsViewModel>.reactive(
      viewModelBuilder: () => ProjectsViewModel(),
      onModelReady: (model) => model.reset(),
      builder: (context, model, child) => ConstrainedWidthWithScaffoldLayout(
        resizeToAvoidBottomInset: false,
        child: RefreshIndicator(
          onRefresh: () async => await model.refresh(),
          child: CustomScrollView(
            key: PageStorageKey('storage-key'),
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              // CustomSliverAppBarSmall(
              //   forceElevated: false,
              //   title: "Social Projects",
              //   onRightIconPressed: model.navigateToFavoritesView,
              //   rightIcon: Icon(Icons.favorite_border_rounded,
              //       color: ColorSettings.pageTitleColor, size: 28),

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

              // =============================================>>>>
              // Temporarily allow user Dan to push new projects to firebase

              // onSecondRightIconPressed:
              //     model.currentUser.uid == "ptWSWNPX4xRyVsb6jwjPfff5C2B3"
              //         ? model.pushGlobalGivingProjectsToFirestore
              //         : null,
              // secondRightIcon: Icon(Icons.plus_one, size: 28),
              //
              // <<<< =============================================
              //),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: LayoutSettings.horizontalPadding,
                    left: 0.5 * LayoutSettings.horizontalPadding,
                    right: LayoutSettings.horizontalPadding,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.all(0.0),
                        onPressed: model.navigateBack,
                        icon: Icon(Icons.arrow_back_rounded,
                            color: ColorSettings.blackHeadlineColor, size: 28),
                      ),
                      horizontalSpaceRegular,
                      Expanded(
                        child: GreySearchTextField(
                          controller: textFieldController,
                          hintText: "Search with one keyword",
                          focusNode: textFieldFocusNode,
                          autofocus: true,
                          onSuffixIconPressed: () {
                            textFieldController.clear();
                            textFieldFocusNode.requestFocus();
                          },
                          suffixIcon: Icon(Icons.close,
                              size: 24, color: Colors.grey[800]),
                          onChanged: (String pattern) async {
                            // await model.queryUsers(pattern);
                            _debouncer.run(() async {
                              await model.queryProjects(pattern);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
                  : model.projectQueryList.length == 0
                      ? SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: LayoutSettings.horizontalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                verticalSpaceLarge,
                                if (!model.isNew) Text("No projects found"),
                              ],
                            ),
                          ),
                        )
                      : ListOfProjectsLayout(
                          projects: model.projectQueryList,
                          isBusy: model.isBusy,
                          showNotImplementedNotification:
                              model.showNotImplementedSnackbar,
                          onProjectTapped: model.navigateToSingleProjectScreen,
                          onFavoriteTapped: model.addOrRemoveFavorite,
                          isFavorite: model.isFavoriteProject,
                        )
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectAreasGrid extends StatelessWidget {
  final List<Project> projectUniqueAreas;
  final List<Project> goodWalletFunds;
  final void Function(String) onPressed;
  const ProjectAreasGrid({
    Key? key,
    required this.projectUniqueAreas,
    required this.goodWalletFunds,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
      ),
      itemCount: projectUniqueAreas.length + 1,
      itemBuilder: (context, index) {
        late Project data;
        if (index == 0) {
          data = goodWalletFunds[index];
        } else {
          data = projectUniqueAreas[index - 1];
        }
        return GlobalGivingProjectCardMobile(
          displayArea: true,
          project: data,
          small: true,
          onTap: () => onPressed(data.area),
        );
      },
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
            height: 200,
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
