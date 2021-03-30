import 'package:flutter/material.dart';
import 'package:good_wallet/app/app.locator.dart';
import 'package:good_wallet/ui/views/goodcauses/causes_viewmodel.dart';
import 'package:good_wallet/ui/widgets/goodcauses/global_giving_project_card.dart';
import 'package:stacked/stacked.dart';

class GoodCausesViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CausesViewModel>.reactive(
      viewModelBuilder: () => locator<CausesViewModel>(),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) async => await model.fetchProjects(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          //backwardsCompatibility: false,
          title: Text("Give you dumbass"),
        ),
        body: model.isBusy
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: model.projects.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GlobalGivingProjectCard(
                    project: model.projects[index],
                    onTap: () async =>
                        await model.navigateToProjectScreen(index),
                  ),
                ),
              ),
      ),
    );
  }
}
