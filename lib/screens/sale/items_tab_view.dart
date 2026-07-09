import 'package:flutter/material.dart';
import 'product_list_view.dart';
import 'service_list_view.dart';

class ItemsTabView extends StatelessWidget {
  final TabController tabController;
  const ItemsTabView({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [
        ProductListView(),
        ServiceListView(),
      ],
    );
  }
}
