import 'package:flutter/material.dart';
import 'package:good_wallet/datamodels/goodcauses/global_giving_project_model.dart';
import 'package:good_wallet/ui/views/goodcauses/single_project_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SingleProjectViewMobile extends StatelessWidget {
  final GlobalGivingProjectModel project;
  const SingleProjectViewMobile({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleProjectViewModel>.reactive(
      viewModelBuilder: () => SingleProjectViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(project.summary),
        ),
      ),
    );
  }
}
