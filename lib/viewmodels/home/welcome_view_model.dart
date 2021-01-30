import 'package:flutter/material.dart';
import 'package:good_wallet/viewmodels/base_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class WelcomeViewModel extends BaseModel {
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
}
