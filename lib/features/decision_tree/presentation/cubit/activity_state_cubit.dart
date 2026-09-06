import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acuteflow/features/decision_tree/data/models/decision_tree_node_model.dart';
import 'package:acuteflow/features/decision_tree/domain/repositories/decision_tree_repository.dart';

abstract class ActivityStateState {
  const ActivityStateState();
}

class ActivityStateInitial extends ActivityStateState {
  const ActivityStateInitial();
}

class ActivityStateLoading extends ActivityStateState {
  const ActivityStateLoading();
}

class ActivityStateLoaded extends ActivityStateState {
  final List<DecisionTreeNodeModel> nodes;

  const ActivityStateLoaded(this.nodes);
}

class ActivityStateError extends ActivityStateState {
  final String message;

  const ActivityStateError(this.message);
}

class ActivityStateCubit extends Cubit<ActivityStateState> {
  final DecisionTreeRepository _repository;

  ActivityStateCubit(this._repository) : super(const ActivityStateInitial());

  Future<void> loadRootStates() async {
    emit(const ActivityStateLoading());
    try {
      final nodes = await _repository.getRootActivityStates();
      emit(ActivityStateLoaded(nodes));
    } catch (e) {
      emit(ActivityStateError('Failed to load activity states: $e'));
    }
  }
}
