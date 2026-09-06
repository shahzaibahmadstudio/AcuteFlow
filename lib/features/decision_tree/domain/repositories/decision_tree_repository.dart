import 'package:acuteflow/features/decision_tree/data/models/decision_tree_node_model.dart';

abstract class DecisionTreeRepository {
  Future<List<DecisionTreeNodeModel>> getRootActivityStates();

  Future<DecisionTreeNodeModel?> getStateById(String id);
}
