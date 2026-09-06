import 'package:acuteflow/features/decision_tree/data/models/remedy_model.dart';
import 'package:acuteflow/features/decision_tree/domain/repositories/remedy_repository.dart';
import 'package:hive/hive.dart';

class RemedyRepositoryImpl implements RemedyRepository {
  final Box<RemedyModel> _remedyBox;

  RemedyRepositoryImpl(this._remedyBox);

  @override
  Future<RemedyModel?> getRemedyById(String id) async {
    return _remedyBox.get(id);
  }

  @override
  Future<List<RemedyModel>> getAllRemedies() async {
    return _remedyBox.values.toList();
  }

  @override
  Future<List<RemedyModel>> searchRemedies(String query) async {
    if (query.isEmpty) return getAllRemedies();
    final lowerQuery = query.toLowerCase();
    return _remedyBox.values.where((remedy) {
      return remedy.name.toLowerCase().contains(lowerQuery) ||
          remedy.id.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
