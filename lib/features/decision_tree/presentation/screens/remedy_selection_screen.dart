import 'package:acuteflow/core/utils/toggle_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:acuteflow/consts/constants.dart';
import 'package:acuteflow/core/di/injection_container.dart';
import 'package:acuteflow/features/decision_tree/data/models/decision_tree_node_model.dart';
import 'package:acuteflow/features/decision_tree/data/models/remedy_model.dart';
import 'package:acuteflow/features/decision_tree/presentation/cubit/remedy_selection_cubit.dart';
import 'package:acuteflow/features/decision_tree/presentation/screens/remedy_detail_screen.dart';
import 'package:acuteflow/core/utils/icon_mapper.dart';

class RemedySelectorScreen extends StatelessWidget {
  final DecisionTreeNodeModel node;
  final DecisionTreeNodeModel? rootNode;

  const RemedySelectorScreen({super.key, required this.node, this.rootNode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RemedySelectionCubit>()..init(node),
      child: _RemedySelectorView(node: node, rootNode: rootNode),
    );
  }
}

class _RemedySelectorView extends StatelessWidget {
  final DecisionTreeNodeModel node;
  final DecisionTreeNodeModel? rootNode;

  const _RemedySelectorView({required this.node, this.rootNode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AcuteFlowColors.secondaryWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.s(24))
              .copyWith(top: context.s(48), bottom: context.s(48)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.s(24)),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SvgPicture.asset(
                  AcuteFlowIcons.arrowBack,
                  height: context.s(24),
                  width: context.s(24),
                  colorFilter: const ColorFilter.mode(
                    AcuteFlowColors.primaryNavy,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(height: context.s(32)),
              Center(
                child: SvgPicture.asset(
                  iconForNodeId(rootNode?.id ?? node.id),
                  height: context.s(54),
                  width: context.s(54),
                  colorFilter: const ColorFilter.mode(
                    AcuteFlowColors.primaryNavy,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(height: context.s(16)),
              Center(
                child: SizedBox(
                  width: context.s(324),
                  child: Text(
                    "Understand the patient core thermal sensitivity and fluid needs and select an ideal remedy",
                    textAlign: TextAlign.center,
                    style: AcuteFlowTextStyles.i18.copyWith(height: 1.2),
                  ),
                ),
              ),
              SizedBox(height: context.s(48)),
              Expanded(
                child: BlocBuilder<RemedySelectionCubit, RemedySelectionState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.showThermalToggle) ...[
                          Row(
                            children: [
                              Expanded(
                                child: _ToggleChip(
                                  label: "Chilly",
                                  selected:
                                      state.thermal ==
                                      ThermalSensitivity.chilly,
                                  variant: _ToggleVariant.primary,
                                  radiusPosition: _RadiusPosition.left,
                                  onTap: () => context
                                      .read<RemedySelectionCubit>()
                                      .selectThermal(ThermalSensitivity.chilly),
                                ),
                              ),
                              Expanded(
                                child: _ToggleChip(
                                  label: "Hot",
                                  selected:
                                      state.thermal == ThermalSensitivity.hot,
                                  variant: _ToggleVariant.primary,
                                  radiusPosition: _RadiusPosition.right,
                                  onTap: () => context
                                      .read<RemedySelectionCubit>()
                                      .selectThermal(ThermalSensitivity.hot),
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (state.showThermalToggle && state.showFluidToggle)
                          SizedBox(height: context.s(12)),
                        if (state.showFluidToggle) ...[
                          Row(
                            children: [
                              Expanded(
                                child: _ToggleChip(
                                  label: "Thirsty",
                                  selected: state.fluid == FluidNeed.thirsty,
                                  variant: _ToggleVariant.secondary,
                                  radiusPosition: _RadiusPosition.left,
                                  onTap: () => context
                                      .read<RemedySelectionCubit>()
                                      .selectFluid(FluidNeed.thirsty),
                                ),
                              ),
                              Expanded(
                                child: _ToggleChip(
                                  label: "Thirstless",
                                  selected: state.fluid == FluidNeed.thirstless,
                                  variant: _ToggleVariant.secondary,
                                  radiusPosition: _RadiusPosition.right,
                                  onTap: () => context
                                      .read<RemedySelectionCubit>()
                                      .selectFluid(FluidNeed.thirstless),
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (state.showThermalToggle || state.showFluidToggle)
                          SizedBox(height: context.s(36)),

                        Text(
                          "Suggested Remedies",
                          style: AcuteFlowTextStyles.i20,
                        ),
                        SizedBox(height: context.s(2)),
                        Text(
                          "Click to view details",
                          style: AcuteFlowTextStyles.i16,
                        ),
                        SizedBox(height: context.s(18)),
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (state.isLoading)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: context.s(24),
                                      ),
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  else if (state.error != null)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: context.s(24),
                                      ),
                                      child: Text(
                                        state.error!,
                                        style: AcuteFlowTextStyles.i16,
                                      ),
                                    )
                                  else
                                    ..._buildRemedyRows(
                                      context,
                                      state.remedies,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRemedyRows(
    BuildContext context,
    List<RemedyModel> remedies,
  ) {
    final rows = <Widget>[];
    for (var i = 0; i < remedies.length; i += 2) {
      final hasSecond = i + 1 < remedies.length;
      rows.add(
        Row(
          children: [
            Expanded(
              child: _RemedyPill(
                label: remedies[i].name,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RemedyDetailsScreen(remedy: remedies[i]),
                  ),
                ),
              ),
            ),
            SizedBox(width: context.s(8)),
            Expanded(
              child: hasSecond
                  ? _RemedyPill(
                      label: remedies[i + 1].name,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              RemedyDetailsScreen(remedy: remedies[i + 1]),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
      if (i + 2 < remedies.length) {
        rows.add(SizedBox(height: context.s(8)));
      }
    }
    return rows;
  }
}

enum _ToggleVariant { primary, secondary }

enum _RadiusPosition { left, right }

class _ToggleChip extends StatelessWidget {
  final String label;
  final bool selected;
  final _ToggleVariant variant;
  final _RadiusPosition radiusPosition;
  final VoidCallback onTap;

  const _ToggleChip({
    required this.label,
    required this.selected,
    required this.variant,
    required this.radiusPosition,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = variant == _ToggleVariant.primary;
    final double height = isPrimary ? context.s(56) : context.s(48);
    final radius = Radius.circular(context.s(24));
    final borderRadius = radiusPosition == _RadiusPosition.left
        ? BorderRadius.only(topLeft: radius, bottomLeft: radius)
        : BorderRadius.only(topRight: radius, bottomRight: radius);

    Color bgColor;
    Color textColor;
    Border? border;

    if (isPrimary) {
      if (selected) {
        bgColor = AcuteFlowColors.primaryNavy;
        textColor = AcuteFlowColors.secondaryWhite;
        border = null;
      } else {
        bgColor = AcuteFlowColors.secondaryWhite;
        textColor = Colors.black;
      }
    } else {
      if (selected) {
        bgColor = AcuteFlowColors.primaryNavy.withAlpha(64);
        textColor = AcuteFlowColors.primaryNavy;
        border = null;
      } else {
        bgColor = AcuteFlowColors.secondaryWhite;
        textColor = Colors.black;
        border = Border.all(
          color: AcuteFlowColors.primaryNavy.withAlpha(64),
          width: context.s(2),
        );
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: borderRadius,
          border: border,
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: AcuteFlowColors.primaryNavy.withAlpha(32),
                    blurRadius: context.s(32),
                    spreadRadius: context.s(8),
                    offset: Offset(0, context.s(8)),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: AcuteFlowTextStyles.i18.copyWith(
            fontSize: context.sp(18),
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class _RemedyPill extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _RemedyPill({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.s(84),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: context.s(12)),
        decoration: BoxDecoration(
          color: AcuteFlowColors.secondaryWhite,
          borderRadius: BorderRadius.circular(context.s(36)),
          border: Border.all(
            color: AcuteFlowColors.primaryNavy,
            width: context.s(2),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AcuteFlowTextStyles.i18.copyWith(
            fontSize: context.sp(18),
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
