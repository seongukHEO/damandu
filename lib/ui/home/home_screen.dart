import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/app_colors.dart';
import '../../common/app_fonts.dart';
import '../../provider/home/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime? lastBackPress;


    final selectIndex = ref.watch(selectedIndexProvider);
    final tabNotifier = ref.read(selectedIndexProvider.notifier);

    return PopScope(
      canPop: false, // 시스템 기본 뒤로가기 동작 차단
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final now = DateTime.now();
        if (lastBackPress == null || now.difference(lastBackPress!) > Duration(seconds: 2)) {
          lastBackPress = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('뒤로 가기 버튼을 한 번 더 누르면 종료됩니다.', style: AppFonts.preRegular(size: 14, color: Colors.white),),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          // 앱 종료
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            navigationBarTheme: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppFonts.preSemiBold(size: 12, color: AppColors.gold(9));
                }
                return AppFonts.preRegular(size: 12, color: AppColors.gold(9).withOpacity(0.6));
              }),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15), // 그림자 색상 및 강도 조절
                  blurRadius: 20,
                  offset: const Offset(0, -4), // 위쪽 방향 그림자
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: NavigationBar(
                backgroundColor: AppColors.khakiBeige(5),
                onDestinationSelected: (index) {
                  tabNotifier.setIndex(index);
                },
                indicatorColor: Colors.transparent,
                shadowColor: Colors.transparent, // 내부 그림자는 제거
                selectedIndex: selectIndex,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                destinations: [
                  _buildNavigationDestinationWithIndicator(
                    icon: selectIndex == 0
                        ? Icon(Icons.home, color: AppColors.gold(9))
                        : Icon(Icons.home_outlined, color: AppColors.gold(9).withOpacity(0.6)),
                    label: "홈",
                  ),
                  _buildNavigationDestinationWithIndicator(
                    icon: selectIndex == 1
                        ? Icon(Icons.chat, color: AppColors.gold(9))
                        : Icon(Icons.chat_outlined, color: AppColors.gold(9).withOpacity(0.6)),
                    label: "숙성 이야기",
                  ),
                  _buildNavigationDestinationWithIndicator(
                    icon: selectIndex == 2
                        ? Icon(Icons.sell, color: AppColors.gold(9))
                        : Icon(Icons.sell_outlined, color: AppColors.gold(9).withOpacity(0.6)),
                    label: "제품",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildNavigationDestinationWithIndicator({
    required Widget icon,
    required String label,
    bool hasIndicator = false,
  }) {
    return NavigationDestination(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          icon,
          if (hasIndicator)
            Positioned(
              top: 2,
              right: -1,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.dark(5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
      label: label,
    );
  }
}
