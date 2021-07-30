import 'package:flutter/material.dart';
import 'package:good_wallet/ui/views/common_viewmodels/base_viewmodel.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class WelcomeViewModel extends BaseModel {
  bool _hovering = true;
  bool get hovering => _hovering;
  String _explanationText = "Are you interested in our vision? Click here!";
  String get explanationText => _explanationText;

  double? imageHeight;

  double currentOffset = 0;

  final _scrollController = AutoScrollController(
    // TODO:
    // viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
    // make it responsive!
    viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, 0),
    axis: Axis.horizontal,
  );
  ScrollController get scrollController => _scrollController;

  void jumpToGraphic() {
    //_scrollController.jumpTo(1);
    _scrollController.scrollToIndex(1,
        preferPosition: AutoScrollPosition.begin);
  }

  void changeTextOnHover() {
    if (_hovering) {
      _explanationText =
          "This is a super cool text because you hover over the button!";
    } else {
      _explanationText = "Are you interested in our vision? Click here!";
    }
    _hovering = !_hovering;
    notifyListeners();
  }

  bool handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      currentOffset = notification.metrics.pixels;
    }
    notifyListeners();
    return false;
  }
}
