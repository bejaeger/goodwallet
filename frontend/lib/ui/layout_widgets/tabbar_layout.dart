import 'package:flutter/material.dart';
import 'package:good_wallet/ui/layout_widgets/constrained_width_layout.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/shared/style_settings.dart';
import 'package:good_wallet/ui/widgets/custom_app_bar_small.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

// Layout for view using a tab bar

class TabBarLayout extends StatefulWidget {
  final String title;
  final double titleSize;
  final List<Widget> tabs;
  final List<Widget> views;
  final int initialIndex;

  final Widget? titleTrailingWidget;

  const TabBarLayout({
    Key? key,
    required this.title,
    required this.tabs,
    required this.views,
    this.titleSize = Style.pageHeaderSize,
    this.initialIndex = 0,
    this.titleTrailingWidget,
  }) : super(key: key); //
  @override
  _TabBarLayoutState createState() => _TabBarLayoutState();
}

class _TabBarLayoutState extends State<TabBarLayout>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedWidthWithScaffoldLayout(
      // Note: Maybe here we can use a NestedScrollView to achieve
      // nice effects with sliver?
      child: Column(
        children: [
          verticalSpaceTiny,
          CustomAppBarSmall(
            height: LayoutSettings.minAppBarHeight +
                LayoutSettings.tabBarPreferredHeight,
            title: widget.title,
            titleSize: widget.titleSize,
            rightWidget: widget.titleTrailingWidget,
            bottom: PreferredSize(
              preferredSize: Size(
                  screenWidth(context), LayoutSettings.tabBarPreferredHeight),
              child: Container(
                child: TabBar(
                  controller: _tabController,
                  tabs: widget.tabs,
                  labelPadding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  indicatorColor: Colors.grey,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: textTheme(context).bodyText2!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: LayoutSettings.horizontalPadding),
              child: TabBarView(
                  controller: _tabController,
                  // These are the contents of the tab views, below the tabs.
                  children: widget.views),
            ),
          ),
        ],
      ),
    );
  }
}
