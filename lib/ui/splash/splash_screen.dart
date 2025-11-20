import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  String fullText = "GoldBarrel";
  String displayText = "";
  double subtitleOpacity = 0.0;
  bool hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  void _animateText() async {
    for (int i = 0; i <= fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      if (!mounted) return;
      setState(() {
        displayText = fullText.substring(0, i);
      });
    }

    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        subtitleOpacity = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // // 로그인 상태 모니터링
    // ref.listen<AsyncValue<bool>>(splashViewModelProvider, (_, state) {
    //   if (hasNavigated) return;
    //
    //   state.when(
    //     data: (isLoggedIn) {
    //       hasNavigated = true;
    //       context.go(isLoggedIn ? RoutePath.home : RoutePath.login);
    //     },
    //     loading: () {
    //       debugPrint("SplashScreen: Loading user state...");
    //     },
    //     error: (error, _) {
    //       hasNavigated = true;
    //       debugPrint("SplashScreen: Error - $error");
    //       context.go(RoutePath.login);
    //     },
    //   );
    // });

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
                    '한 잔의 멋과 품격을 담다',
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
