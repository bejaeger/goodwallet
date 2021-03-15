import 'package:flutter/material.dart';
import 'package:good_wallet/ui/views/goodcauses/causes_view_mobile.dart';
import 'package:good_wallet/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeViewMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => CustomScrollView(
        key: PageStorageKey('storage-key'),
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          // Todo: create custom SliverAppPersistentHeader
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return Future<void>.value();
            },
            expandedHeight: 250.0,
            titleSpacing: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              title: const Text('The Good Wallet'),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(
                    'https://burst.shopifycdn.com/photos/hands-hold-red-apple.jpg?width=373&format=pjpg&exif=0&iptc=0',
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment(0.0, 0.0),
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 250, child: Text("Item 1")),
              Center(
                child: ElevatedButton(
                    onPressed: () => model.showRaiseMoneyBottomSheet(),
                    child: Text("Raise Money")),
              ),
              SizedBox(height: 250, child: Text("Item 2")),
            ]),
          ),
        ],
      ),
    );
  }
}
