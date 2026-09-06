import 'package:hive/hive.dart';
part 'decision_tree_node_model.g.dart';

@HiveType(typeId: 1)
class DecisionTreeNodeModel extends HiveObject {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? label;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final bool? requiresThermal;

  @HiveField(4)
  final bool? requiresHydration;

  @HiveField(5)
  final List<String>? remedies;

  @HiveField(6)
  final Map<String, List<String>>? branches;

  @HiveField(7)
  final Map<String, List<String>>? matrix;

  @HiveField(8)
  final List<DecisionTreeNodeModel>? subCategories;

  DecisionTreeNodeModel({
    this.id,
    this.label,
    this.description,
    this.requiresThermal,
    this.requiresHydration,
    this.remedies,
    this.branches,
    this.matrix,
    this.subCategories,
  });

  factory DecisionTreeNodeModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>>? parseStringListMap(dynamic mapData) {
      if (mapData == null) return null;
      final rawMap = mapData as Map<String, dynamic>;
      return rawMap.map((key, value) {
        if (value is Map && value.containsKey('remedies')) {
          return MapEntry(key, List<String>.from(value['remedies']));
        }
        return MapEntry(key, List<String>.from(value as List));
      });
    }

    final rawChildren = (json['sub_categories'] ?? json['types']) as List?;
    final parsedChildren = rawChildren
        ?.map((e) => DecisionTreeNodeModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return DecisionTreeNodeModel(
      id: json['id'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      requiresThermal: json['requires_thermal'] as bool?,
      requiresHydration: json['requires_hydration'] as bool?,
      remedies: json['remedies'] != null
          ? List<String>.from(json['remedies'])
          : null,
      branches: parseStringListMap(json['branches']),
      matrix: parseStringListMap(json['matrix']),
      subCategories: parsedChildren,
    );
  }
}
