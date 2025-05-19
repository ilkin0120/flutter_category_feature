import 'package:flutter/material.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

class TabBarWithView extends StatefulWidget {
  final TabController? tabController;
  final List<String> tabTitles;
  final List<Widget> tabViews;

  const TabBarWithView(
      {super.key,
      required this.tabTitles,
      required this.tabViews,
      this.tabController})
      : assert(tabTitles.length == tabViews.length,
            'Количество заголовков должно совпадать с количеством страниц');

  @override
  State<TabBarWithView> createState() => _TabBarWithViewState();
}

class _TabBarWithViewState extends State<TabBarWithView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = widget.tabController ??
        TabController(length: widget.tabTitles.length, vsync: this);
  }

  @override
  void dispose() {
    if (widget.tabController == null) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: context.color.primaryColor,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
          dividerHeight: 0,
          unselectedLabelStyle: context.text.bodyLarge
              .copyWith(color: context.color.secondaryTextColor),
          labelStyle: context.text.bodyLarge
              .copyWith(color: context.color.primaryColor),
          tabs: widget.tabTitles.map((title) => Tab(text: title)).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabViews,
          ),
        ),
      ],
    );
  }
}
