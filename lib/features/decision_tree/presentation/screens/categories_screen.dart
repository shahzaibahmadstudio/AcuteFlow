import 'package:acuteflow/core/utils/node_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:acuteflow/consts/constants.dart';
import 'package:acuteflow/core/utils/icon_mapper.dart';
import 'package:acuteflow/features/decision_tree/data/models/decision_tree_node_model.dart';

class ActivityStateCategoryScreen extends StatelessWidget {
  final DecisionTreeNodeModel parentNode;
  final DecisionTreeNodeModel? rootNode;

  const ActivityStateCategoryScreen({
    super.key,
    required this.parentNode,
    this.rootNode,
  });

  @override
  Widget build(BuildContext context) {
    final options = parentNode.subCategories ?? const [];

    return Scaffold(
      backgroundColor: AcuteFlowColors.secondaryWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.s(32)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.s(48)),
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
              SizedBox(height: context.s(48)),
              Center(
                child: SvgPicture.asset(
                  iconForNodeId(rootNode?.id ?? parentNode.id),
                  height: context.s(64),
                  width: context.s(64),
                  colorFilter: const ColorFilter.mode(
                    AcuteFlowColors.primaryNavy,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(height: context.s(24)),
              Center(
                child: SizedBox(
                  width: context.s(324),
                  child: Text(
                    "Pin point the nature of this state to identify the most precise remedy.",
                    textAlign: TextAlign.center,
                    style: AcuteFlowTextStyles.i18,
                  ),
                ),
              ),
              SizedBox(height: context.s(48)),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: context.s(16),
                    runSpacing: context.s(16),
                    children: options
                        .map(
                          (child) => _OptionPill(
                            label: child.label ?? '',
                            onTap: () => navigateFromNode(
                              context,
                              child,
                              rootNode: rootNode ?? parentNode,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionPill extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _OptionPill({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.s(84),
        constraints: BoxConstraints(minWidth: context.s(180)),
        padding: EdgeInsets.symmetric(horizontal: context.s(24)),
        decoration: BoxDecoration(
          color: AcuteFlowColors.secondaryWhite,
          borderRadius: BorderRadius.circular(context.s(36)),
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
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AcuteFlowTextStyles.i18.copyWith(
            fontSize: context.sp(18),
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
