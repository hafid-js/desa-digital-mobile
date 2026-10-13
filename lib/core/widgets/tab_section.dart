import 'package:desa_digital/core/widgets/pill_tab_bar.dart';
import 'package:flutter/material.dart';

class TabSection extends StatelessWidget {
  const TabSection({
    super.key,
    required this.labels,
    required this.tabs,
    this.barPadding = const EdgeInsets.all(16),
  });

  final List<String> labels;
  final List<Widget> tabs;
  final EdgeInsets barPadding;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: labels.length,
      child: Builder(
        builder: (context) {
          final controller = DefaultTabController.of(context);

          return Column(
            children: [
              PillTabBar(
                labels: labels,
                controller: controller,
                padding: barPadding,
              ),
              Expanded(child: TabBarView(children: tabs)),
            ],
          );
        },
      ),
    );
  }
}
