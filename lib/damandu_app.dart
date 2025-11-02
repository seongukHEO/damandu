import 'package:damandu/router.dart';
import 'package:flutter/material.dart';

import 'common/app_colors.dart';
import 'common/app_fonts.dart';

class DamanduApp extends StatefulWidget {
  const DamanduApp({super.key});

  @override
  State<DamanduApp> createState() => _FounderAppState();
}

class _FounderAppState extends State<DamanduApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: _FounderThemeData(context), // 여기서 테마를 적용
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _FounderThemeData(BuildContext context) => ThemeData(
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.dark(5), // ✅ CircularProgressIndicator 색상 설정
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle:
        AppFonts.preSemiBold(size: 16, color: AppColors.dark(5))as TextStyle,
        scrolledUnderElevation: 0,
        elevation: 0),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.dark(5),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fixedSize: Size(MediaQuery.of(context).size.width - 32, 56),
        padding: EdgeInsets.zero,
        textStyle: AppFonts.preSemiBold(size: 20, color: Colors.white) as TextStyle,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.gold(9); // 체크된 상태일 때 배경색
            }
            return Colors.transparent; // 체크되지 않은 상태일 때 배경색
          }),
      checkColor: const WidgetStatePropertyAll(Colors.white), // 체크 마크 색상
      shape: const CircleBorder(), // 원형 모양
      side: BorderSide(color: AppColors.khakiBeige(6), width: 1.5), // 테두리 색상
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,  // 👉 커서 색상을 검정으로 설정
      selectionColor: Colors.black.withOpacity(0.3), // 👉 선택된 텍스트 배경색
      selectionHandleColor: Colors.black, // 👉 텍스트 선택 핸들 색상
    ),
    fontFamily: AppFonts.pretendard,
    scaffoldBackgroundColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    useMaterial3: true,
  );
}
