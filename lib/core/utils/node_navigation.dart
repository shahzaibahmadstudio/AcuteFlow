import 'package:flutter/material.dart';
import 'package:acuteflow/features/decision_tree/data/models/decision_tree_node_model.dart';
import 'package:acuteflow/features/decision_tree/presentation/screens/categories_screen.dart';
import 'package:acuteflow/features/decision_tree/presentation/screens/remedy_selection_screen.dart';

void navigateFromNode(
  BuildContext context,
  DecisionTreeNodeModel node, {
  DecisionTreeNodeModel? rootNode,
}) {
  final hasSubCategories =
      node.subCategories != null && node.subCategories!.isNotEmpty;

  if (hasSubCategories) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ActivityStateCategoryScreen(
          parentNode: node,
          rootNode: rootNode ?? node,
        ),
      ),
    );
  } else {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            RemedySelectorScreen(node: node, rootNode: rootNode ?? node),
      ),
    );
  }
}
