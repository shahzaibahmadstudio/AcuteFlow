import 'package:acuteflow/features/decision_tree/data/models/decision_tree_node_model.dart';
import 'package:acuteflow/features/decision_tree/data/models/remedy_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'asset_manifest_service.dart';

class HiveService {
  static const String remedyBoxName = 'remedies_box';
  static const String decisionTreeBoxName = 'decision_tree_box';
  static const String metaBoxName = 'app_metadata_box';
  static const String isSeededKey = 'is_seeded';

  final AssetManifestService _assetService;

  HiveService(this._assetService);

  Future<void> initDatabase() async {
    await Hive.initFlutter();

    Hive.registerAdapter(RemedyModelAdapter());
    Hive.registerAdapter(DecisionTreeNodeModelAdapter());

    final remedyBox = await Hive.openBox<RemedyModel>(remedyBoxName);
    final treeBox = await Hive.openBox<DecisionTreeNodeModel>(
      decisionTreeBoxName,
    );
    final metaBox = await Hive.openBox<dynamic>(metaBoxName);

    final bool isSeeded = metaBox.get(isSeededKey, defaultValue: false) as bool;

    if (!isSeeded) {
      await _seedData(remedyBox, treeBox, metaBox);
    }
  }

  Future<void> _seedData(
    Box<RemedyModel> remedyBox,
    Box<DecisionTreeNodeModel> treeBox,
    Box<dynamic> metaBox,
  ) async {
    final rawRemedies = await _assetService.loadRawRemedies();
    final Map<String, RemedyModel> remedyMap = {};
    for (var item in rawRemedies) {
      final model = RemedyModel.fromJson(item as Map<String, dynamic>);
      remedyMap[model.id] = model;
    }
    await remedyBox.putAll(remedyMap);

    final rawTree = await _assetService.loadRawDecisionTree();
    final rootNodes = (rawTree['activity_states'] as List)
        .map((e) => DecisionTreeNodeModel.fromJson(e as Map<String, dynamic>))
        .toList();

    for (var i = 0; i < rootNodes.length; i++) {
      await treeBox.put('state_$i', rootNodes[i]);
    }

    await metaBox.put(isSeededKey, true);
  }
}
