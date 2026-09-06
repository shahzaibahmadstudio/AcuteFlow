import 'package:acuteflow/consts/constants.dart';

String iconForNodeId(String? id) {
  switch (id) {
    case 'increased_activity':
      return AcuteFlowIcons.aboveNormal;
    case 'decreased_activity':
      return AcuteFlowIcons.belowNormal;
    case 'no_change':
      return AcuteFlowIcons.noChange;
    case 'awota':
      return AcuteFlowIcons.awota;
    default:
      return AcuteFlowIcons.noChange;
  }
}
