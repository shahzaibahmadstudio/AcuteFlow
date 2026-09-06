import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:acuteflow/consts/constants.dart';
import 'package:acuteflow/core/di/injection_container.dart';
import 'package:acuteflow/core/utils/icon_mapper.dart';
import 'package:acuteflow/features/decision_tree/data/models/decision_tree_node_model.dart';
import 'package:acuteflow/features/decision_tree/presentation/cubit/activity_state_cubit.dart';
import 'package:acuteflow/core/utils/node_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ActivityStateCubit>()..loadRootStates(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AcuteFlowColors.secondaryWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.s(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: context.s(56)),
              Text(
                "AcuteFlow",
                textAlign: TextAlign.center,
                style: AcuteFlowTextStyles.i24,
              ),
              SizedBox(height: context.s(38)),
              SizedBox(
                width: context.s(324),
                child: Text(
                  "To map the right remedy path, please describe the patient's activity state.",
                  textAlign: TextAlign.center,
                  style: AcuteFlowTextStyles.i18,
                ),
              ),
              SizedBox(height: context.s(64)),
              Expanded(
                child: BlocBuilder<ActivityStateCubit, ActivityStateState>(
                  builder: (context, state) {
                    if (state is ActivityStateLoading ||
                        state is ActivityStateInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ActivityStateError) {
                      return Center(
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: AcuteFlowTextStyles.i16,
                        ),
                      );
                    }

                    final nodes = (state as ActivityStateLoaded).nodes;
                    return _ActivityGrid(nodes: nodes);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityGrid extends StatelessWidget {
  final List<DecisionTreeNodeModel> nodes;

  const _ActivityGrid({required this.nodes});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: context.s(18),
        runSpacing: context.s(18),
        children: nodes
            .map(
              (node) => _ActivityCard(
                label: node.label ?? '',
                icon: iconForNodeId(node.id),
                onTap: () => navigateFromNode(context, node),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.s(180),
        width: context.s(180),
        decoration: BoxDecoration(
          color: AcuteFlowColors.secondaryWhite,
          borderRadius: BorderRadius.circular(context.s(48)),
          border: Border.all(
            color: AcuteFlowColors.primaryNavy,
            width: context.s(4),
          ),
          boxShadow: [
            BoxShadow(
              color: AcuteFlowColors.primaryNavy.withAlpha(31),
              blurRadius: context.s(32),
              spreadRadius: context.s(8),
              offset: Offset(0, context.s(8)),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: context.s(48),
              width: context.s(48),
              colorFilter: const ColorFilter.mode(
                AcuteFlowColors.primaryNavy,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: context.s(16)),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AcuteFlowTextStyles.i18.copyWith(
                fontSize: context.sp(18),
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
