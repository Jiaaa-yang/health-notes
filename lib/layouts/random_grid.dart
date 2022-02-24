import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Layout widget to randomly place list of
/// children widgets in a grid manner
class RandomGrid extends StatelessWidget {
  /// List of children widgets to layout
  final List<Widget> children;

  /// Number of tiles in cross axis
  final int crossAxisCount;

  static final Random rng = Random();

  const RandomGrid({Key? key,
    required this.children,
    required this.crossAxisCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define minimum and maximum cell count for
    // each widget to be 10% and 50% of total tiles
    int minCellCount = (0.10 * this.crossAxisCount).ceil();
    int maxCellCount = (0.50 * this.crossAxisCount).ceil();

    return StaggeredGrid.count(
      crossAxisCount: crossAxisCount,
      children: this.children.map((widget) =>
          StaggeredGridTile.count(
            crossAxisCellCount: rng.nextInt(maxCellCount) + minCellCount,
            mainAxisCellCount: rng.nextInt(maxCellCount) + minCellCount,
            child: widget,
          )
      ).toList(),
    );
  }
}
