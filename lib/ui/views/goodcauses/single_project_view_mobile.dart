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
        appBar: AppBar(
          title: Text(project.title),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 500.0,
                height: 100.0,
                child: Image.network(
                  project.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: TextField(decoration: InputDecoration(hintText: '\$'))
                    ),
                    Expanded(child:
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Donate'))),
                    // Expanded(
                    //   child: ElevatedButton(
                    //       onPressed: () {
                    //         print('Surprise Motherfucker');
                    //       },
                    //       child: Text("Donate")),
                    // ),
                    // IconButton(
                    //   iconSize: 60.0,
                    //   onPressed: () {
                    //     print("Liked");
                    //   },
                    //   icon: Icon(
                    //     Icons.favorite_border,
                    //     color: Colors.red,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
              Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Icon(
                              Icons.account_balance_wallet
                            ),
                            Text("\$ 1200",
                        style: TextStyle(
                          fontSize: 20.0)
                            )],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              Icons.support
                            ),
                            Text("\$ 0",
                          style: TextStyle(
                          fontSize: 20.0)
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Container(
                    child: Expanded(
                      child: Text(project.summary,
                          softWrap: true, style: TextStyle(fontSize: 15.0)),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
