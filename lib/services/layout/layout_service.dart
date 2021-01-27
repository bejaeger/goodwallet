import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class LayoutService with ReactiveServiceMixin {
  RxValue<bool> _showNavigationBar = RxValue<bool>(initial: true);
  bool get showNavigationBar => _showNavigationBar.value;

  void setShowNavigationBar(bool show) {
    _showNavigationBar.value = show;
  }

  LayoutService() {
    listenToReactiveValues([_showNavigationBar]);
  }
}
