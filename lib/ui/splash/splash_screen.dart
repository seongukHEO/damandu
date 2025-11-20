import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/shared_preference_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  String fullText = "대만두";
  String displayText = "";
  double subtitleOpacity = 0.0;
  bool hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  /// 🔥 텍스트 애니메이션 + 로그인 체크 순서
  void _animateText() async {
    // 글자 출력
    for (int i = 0; i <= fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      if (!mounted) return;
      setState(() {
        displayText = fullText.substring(0, i);
      });
    }

    // 부제 Fade-in
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        subtitleOpacity = 1.0;
      });
    }

    // 🔥 애니메이션이 끝난 후 로그인 체크
    await Future.delayed(const Duration(milliseconds: 800));
    _checkLogin();
  }

  /// 🔥 uid 여부 체크
  Future<void> _checkLogin() async {
    if (hasNavigated) return;

    final uid = await SharedPreferenceProvider.getUid();
    debugPrint("🔍 Splash UID: $uid");

    hasNavigated = true;

    if (!mounted) return;

    if (uid != null && uid.isNotEmpty) {
      context.go(RoutePath.home);
    } else {
      context.go(RoutePath.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5A3E2B), Color(0xFFD6BFA2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const Spacer(flex: 1),
                Text(
                  displayText,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 52,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedOpacity(
                  opacity: subtitleOpacity,
                  duration: const Duration(seconds: 1),
                  child: Text(
                    '최고의 만두를 찾아 대만두',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
