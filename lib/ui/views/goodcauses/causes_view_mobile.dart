import 'package:flutter/material.dart';
import 'package:good_wallet/ui/views/goodcauses/causes_viewmodel.dart';
import 'package:stacked/stacked.dart';

class GoodCausesViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CausesViewModel>.reactive(
      viewModelBuilder: () => CausesViewModel(),
      onModelReady: (model) async => await model.fetchProjects(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Give you dumbass"),
        ),
        body: model.projects == null
            ? LinearProgressIndicator()
            : ListView.builder(
                itemCount: model.projects.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(model.projects[index].title),
                ),
              ),
      ),
    );
  }
}
