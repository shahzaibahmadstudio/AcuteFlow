import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:acuteflow/consts/constants.dart';
import 'package:acuteflow/features/decision_tree/data/models/remedy_model.dart';

class RemedyDetailsScreen extends StatelessWidget {
  final RemedyModel remedy;

  const RemedyDetailsScreen({super.key, required this.remedy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AcuteFlowColors.secondaryWhite,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.s(32))
                  .copyWith(top: context.s(24), bottom: context.s(140)),
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
                  SizedBox(height: context.s(52)),
                  Center(
                    child: Text(remedy.name, style: AcuteFlowTextStyles.i24),
                  ),
                  SizedBox(height: context.s(40)),
                  Text("Decisive Symptoms", style: AcuteFlowTextStyles.i20),
                  SizedBox(height: context.s(16)),
                  _BulletList(items: remedy.decisiveSymptoms),
                  SizedBox(height: context.s(36)),
                  Text("Other Behaviors", style: AcuteFlowTextStyles.i20),
                  SizedBox(height: context.s(16)),
                  _BulletList(items: remedy.otherBehaviors),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: context.s(32),
              child: Center(
                child: GestureDetector(
                  onTap: () =>
                      Navigator.of(context).popUntil((route) => route.isFirst),
                  child: Container(
                    height: context.s(64),
                    width: context.s(220),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AcuteFlowColors.primaryNavy,
                      borderRadius: BorderRadius.circular(context.s(24)),
                      boxShadow: [
                        BoxShadow(
                          color: AcuteFlowColors.primaryNavy.withAlpha(214),
                          blurRadius: context.s(32),
                          spreadRadius: context.s(8),
                          offset: Offset(0, context.s(8)),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AcuteFlowIcons.home,
                          height: context.s(18),
                          width: context.s(18),
                          colorFilter: const ColorFilter.mode(
                            AcuteFlowColors.secondaryWhite,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: context.s(12)),
                        Text(
                          "Back to Home",
                          style: AcuteFlowTextStyles.i18.copyWith(
                            fontSize: context.sp(18),
                            fontWeight: FontWeight.w500,
                            color: AcuteFlowColors.secondaryWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;

  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: context.s(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.s(27),
                    child: Text(
                      "•",
                      style: AcuteFlowTextStyles.i18.copyWith(
                        fontSize: context.sp(18),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: AcuteFlowTextStyles.i18.copyWith(
                        fontSize: context.sp(18),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
