import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:acuteflow/features/decision_tree/data/models/decision_tree_node_model.dart';
import 'package:acuteflow/features/decision_tree/data/models/remedy_model.dart';
import 'package:acuteflow/features/decision_tree/domain/repositories/remedy_repository.dart';
import 'package:acuteflow/core/utils/toggle_enums.dart';

class RemedySelectionState {
  final DecisionTreeNodeModel? node;
  final bool showThermalToggle;
  final bool showFluidToggle;
  final ThermalSensitivity thermal;
  final FluidNeed fluid;
  final List<RemedyModel> remedies;
  final bool isLoading;
  final String? error;

  const RemedySelectionState({
    this.node,
    this.showThermalToggle = false,
    this.showFluidToggle = false,
    this.thermal = ThermalSensitivity.chilly,
    this.fluid = FluidNeed.thirsty,
    this.remedies = const [],
    this.isLoading = false,
    this.error,
  });

  RemedySelectionState copyWith({
    DecisionTreeNodeModel? node,
    bool? showThermalToggle,
    bool? showFluidToggle,
    ThermalSensitivity? thermal,
    FluidNeed? fluid,
    List<RemedyModel>? remedies,
    bool? isLoading,
    String? error,
  }) {
    return RemedySelectionState(
      node: node ?? this.node,
      showThermalToggle: showThermalToggle ?? this.showThermalToggle,
      showFluidToggle: showFluidToggle ?? this.showFluidToggle,
      thermal: thermal ?? this.thermal,
      fluid: fluid ?? this.fluid,
      remedies: remedies ?? this.remedies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class RemedySelectionCubit extends Cubit<RemedySelectionState> {
  final RemedyRepository _repository;

  RemedySelectionCubit(this._repository) : super(const RemedySelectionState());

  Future<void> init(DecisionTreeNodeModel node) async {
    final showThermal = node.requiresThermal == true;
    final showFluid = node.requiresHydration == true;

    emit(
      state.copyWith(
        node: node,
        showThermalToggle: showThermal,
        showFluidToggle: showFluid,
        thermal: ThermalSensitivity.chilly,
        fluid: FluidNeed.thirsty,
        remedies: const [],
        error: null,
      ),
    );

    await _resolveAndFetch();
  }

  Future<void> selectThermal(ThermalSensitivity thermal) async {
    if (state.thermal == thermal) return;
    emit(state.copyWith(thermal: thermal, error: null));
    await _resolveAndFetch();
  }

  Future<void> selectFluid(FluidNeed fluid) async {
    if (state.fluid == fluid) return;
    emit(state.copyWith(fluid: fluid, error: null));
    await _resolveAndFetch();
  }

  List<String> _resolveRemedyIds() {
    final node = state.node;
    if (node == null) return [];

    final needsThermal = state.showThermalToggle;
    final needsFluid = state.showFluidToggle;

    if (needsThermal && needsFluid) {
      final key = '${state.thermal.key}_${state.fluid.key}';
      return node.matrix?[key] ?? [];
    }

    if (needsThermal) {
      return node.branches?[state.thermal.key] ?? [];
    }

    if (needsFluid) {
      return node.branches?[state.fluid.key] ?? [];
    }

    return node.remedies ?? [];
  }

  Future<void> _resolveAndFetch() async {
    final ids = _resolveRemedyIds();

    emit(state.copyWith(isLoading: true));

    try {
      final remedies = <RemedyModel>[];
      for (final id in ids) {
        final remedy = await _repository.getRemedyById(id);
        if (remedy != null) remedies.add(remedy);
      }
      emit(state.copyWith(remedies: remedies, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, error: 'Failed to load remedies: $e'),
      );
    }
  }
}
