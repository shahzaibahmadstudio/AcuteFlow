import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcuteFlowColors {
  static const Color primaryNavy = Color(0xFF0A192F);
  static const Color secondaryWhite = Color(0xFFF8FAFC);
  static final Color primaryNavyWithOpacity = const Color(0xFF0A192F)
      .withAlpha(180);
  static const Color alertRed = Color(0xFFFF9797);
}

class AcuteFlowTextStyles {
  static final TextStyle i16 = GoogleFonts.inter(
    color: AcuteFlowColors.primaryNavy,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static final TextStyle i18 = GoogleFonts.inter(
    color: AcuteFlowColors.primaryNavy,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static final TextStyle i20 = GoogleFonts.inter(
    color: AcuteFlowColors.primaryNavy,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static final TextStyle i24 = GoogleFonts.inter(
    color: AcuteFlowColors.primaryNavy,
    fontWeight: FontWeight.w900,
    fontSize: 24,
  );
  static final TextStyle i32 = GoogleFonts.inter(
    color: AcuteFlowColors.primaryNavy,
    fontWeight: FontWeight.w800,
    fontSize: 32,
  );
}

class AcuteFlowIcons {
  static const String aboveNormal = "assets/icons/above_normal.svg";
  static const String belowNormal = "assets/icons/below_normal.svg";
  static const String noChange = "assets/icons/no_change.svg";
  static const String awota = "assets/icons/awota.svg";
  static const String arrowBack = "assets/icons/arrow_back.svg";
  static const String home = "assets/icons/home.svg";
}

extension ResponsiveScaler on BuildContext {
  static const double _baseWidth = 440.0;
  static const double _tabletBaseWidth = 835.0;
  static const double _maxDesignWidth = 500.0;

  bool get isTablet => MediaQuery.of(this).size.shortestSide >= 600;

  double get scale {
    final double width = MediaQuery.of(this).size.width;
    if (isTablet) {
      return width / _tabletBaseWidth;
    }
    final targetWidth = width > _maxDesignWidth ? _maxDesignWidth : width;
    return targetWidth / _baseWidth;
  }

  double s(double value) => value * scale;

  double sp(double value) => value * scale;
}
