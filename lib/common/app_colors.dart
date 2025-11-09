import 'package:flutter/material.dart';

class AppColors{
  static Color dark(int shade) {
    return _dark[shade] ?? _dark[5]!;
  }

  static const Map<int, Color> _dark = {
    1: Color(0xFF999CAF),
    2: Color(0xFF7C7F91),
    3: Color(0xFF5F6172),
    4: Color(0xFF424454),
    5: Color(0xFF313346),
    6: Color(0xFF252735),
    7: Color(0xFF1D1E2B),
    8: Color(0xFF14151D),
    9: Color(0xFF0E1016)
  };

  static Color grey(int shade) {
    return _grey[shade] ?? _grey[5]!;
  }

  static const Map<int, Color> _grey = {
    1: Color(0xFFF8F9FB),
    2: Color(0xFFF1F4F8),
    3: Color(0xFFEAEEF4),
    4: Color(0xFFE3E9F0),
    5: Color(0xFFD6DDE9),
    6: Color(0xFFC8D2E1),
    7: Color(0xFFBAC7DA),
    8: Color(0xFF9CA9BC),
    9: Color(0xFF7F8C9F),
  };


  static Color gold(int shade) {
    return _gold[shade] ?? _gold[9]!; // 기본값은 진한 골드
  }

  static const Map<int, Color> _gold = {
    1: Color(0xFFFFF8F0), // 아주 밝은 골드
    2: Color(0xFFF3E4D6),
    3: Color(0xFFE0C2A7),
    4: Color(0xFFCCA87D),
    5: Color(0xFFB78D57),
    6: Color(0xFF9E7140),
    7: Color(0xFF815B34),
    8: Color(0xFF694528),
    9: Color(0xFF5A3E2B), // 기존 gold 컬러
  };

  static Color limeGold(int shade) {
    return _limeGold[shade] ?? _limeGold[7]!; // 기본값은 진한 골드
  }

  static const Map<int, Color> _limeGold = {
    1: Color(0xFFF9FFE8), // 아주 밝은 라이트 라임골드
    2: Color(0xFFEBFFB9),
    3: Color(0xFFDBFF84),
    4: Color(0xFFAAEB44), // 기준 색상 (중간 톤)
    5: Color(0xFF89C83A),
    6: Color(0xFF6BA32F),
    7: Color(0xFF4F7A23), // 어두운 라임골드
  };

  static Color navyContrast(int shade) {
    return _navyContrast[shade] ?? _navyContrast[4]!; // 기본값은 진한 골드
  }


  static const Map<int, Color> _navyContrast = {
    1: Color(0xFFE8F0FF),
    2: Color(0xFFB3C8FF),
    3: Color(0xFF7A9EFF),
    4: Color(0xFF3366CC), // 메인 포인트
    5: Color(0xFF204EA8),
    6: Color(0xFF173A80),
    7: Color(0xFF0D2759),
  };


  static const Map<int, Color> _khakiBeige = {
    1: Color(0xFFFAF6F0), // 아주 밝은 카키 베이지
    2: Color(0xFFF2E9DB),
    3: Color(0xFFEADCC7),
    4: Color(0xFFE2D0B3),
    5: Color(0xFFE5D5BA), // 기준색
    6: Color(0xFFD4C0A6),
    7: Color(0xFFBCA78E),
    8: Color(0xFFA08B72),
    9: Color(0xFF88745E), // 어두운 카키 베이지
  };

  static Color khakiBeige(int shade) {
    return _khakiBeige[shade] ?? _khakiBeige[5]!; // 기본값은 진한 골드
  }


  static const Color greyscale900 = Color(0xFF212121);

  static const Color kakaoBackground = Color(0xFFFEE500);


  static const Color deepBrown = Color(0xFF5A3E2B);

  static const Color backgroundIvory = Color(0xFFFFFDF7);

  static const Color darkGray = Color(0xFF2C2C2C);

}