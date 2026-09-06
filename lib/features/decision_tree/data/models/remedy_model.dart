import 'package:hive/hive.dart';

part 'remedy_model.g.dart';

@HiveType(typeId: 0)
class RemedyModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<String> decisiveSymptoms;

  @HiveField(3)
  final List<String> otherBehaviors;

  RemedyModel({
    required this.id,
    required this.name,
    required this.decisiveSymptoms,
    required this.otherBehaviors,
  });

  factory RemedyModel.fromJson(Map<String, dynamic> json) {
    return RemedyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      decisiveSymptoms: List<String>.from(json['decisive_symptoms'] ?? []),
      otherBehaviors: List<String>.from(json['other_behaviors'] ?? []),
    );
  }
}
