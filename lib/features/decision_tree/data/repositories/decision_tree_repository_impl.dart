import 'package:acuteflow/features/decision_tree/data/models/decision_tree_node_model.dart';
import 'package:acuteflow/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:hive/hive.dart';

class DecisionTreeRepositoryImpl implements DecisionTreeRepository {
  final Box<DecisionTreeNodeModel> _treeBox;

  DecisionTreeRepositoryImpl(this._treeBox);

  @override
  Future<List<DecisionTreeNodeModel>> getRootActivityStates() async {
    return _treeBox.values.toList();
  }

  @override
  Future<DecisionTreeNodeModel?> getStateById(String id) async {
    try {
      return _treeBox.values.firstWhere((node) => node.id == id);
    } catch (_) {
      return null;
    }
  }
}
