import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/style_settings.dart';
import 'package:good_wallet/ui/views/in_app_notifications/in_app_notifications_viewmodel.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/utils/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class InAppNotificationsView extends StatelessWidget {
  const InAppNotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InAppNotificationsViewModel>.reactive(
        viewModelBuilder: () => InAppNotificationsViewModel(),
        builder: (context, model, child) {
          return ConstrainedWidthWithScaffoldLayout(
            child: CustomScrollView(
              key: PageStorageKey('storage-key'),
              slivers: [
                CustomSliverAppBarSmall(
                  title: "Notifications",
                ),
                SliverToBoxAdapter(child: SizedBox(height: 18)),
                model.notifications.isEmpty
                    ? model.isBusy
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : SliverToBoxAdapter(
                            child: Center(
                              child: SizedBox(
                                width: screenWidth(context, percentage: 0.8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text("No new notifications!"),
                                    Text(
                                        "This feature is not yet implemented!"),
                                    Text(
                                        "The idea is to have notifications for every action the user did not initiate."),
                                    Text("For example:"),
                                    Text("- Invitation to money pool"),
                                    Text(
                                        "- User accepts money pool invitation"),
                                    Text("- Receiving payment from peer"),
                                    Text("- Receiving payment from money pool"),
                                    Text("- ...?"),
                                  ],
                                ),
                              ),
                            ),
                          )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            var data = model.notifications[index];
                            return ListTile(
                              title: Text("Notification 1"),
                            );
                          },
                          childCount: model.notifications.length,
                        ),
                      ),
              ],
            ),
          );
        });
  }
}
