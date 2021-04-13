import 'package:flutter/material.dart';
import 'package:good_wallet/enums/transaction_type.dart';
import 'package:good_wallet/ui/shared/layout_settings.dart';
import 'package:good_wallet/ui/views/transaction_history/transactions_history_layout_view.dart';
import 'package:good_wallet/utils/ui_helpers.dart';

// Layout for view using a tab bar

class TabBarLayout extends StatefulWidget {
  final String title;
  final List<Widget> tabs;
  final List<Widget> views;
  final int initialIndex;

  final Widget? titleTrailingWidget;

  const TabBarLayout({
    Key? key,
    required this.title,
    required this.tabs,
    required this.views,
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
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title),
            if (widget.titleTrailingWidget != null) widget.titleTrailingWidget!,
          ],
        ),
        bottom: PreferredSize(
          preferredSize:
              Size(screenWidth(context), LayoutSettings.tabBarPreferredHeight),
          child: Container(
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: widget.tabs,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: LayoutSettings.horizontalPadding),
        child: TabBarView(controller: _tabController, children: widget.views),
      ),
    );
  }
}
