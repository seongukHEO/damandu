import 'package:damandu/common/app_colors.dart';
import 'package:damandu/common/app_fonts.dart';
import 'package:damandu/common/app_images.dart';
import 'package:damandu/provider/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectInfoScreen extends ConsumerStatefulWidget {
  const SelectInfoScreen({super.key});

  @override
  ConsumerState<SelectInfoScreen> createState() => _SelectInfoScreenState();
}

class _SelectInfoScreenState extends ConsumerState<SelectInfoScreen> {


  @override
  Widget build(BuildContext context) {
    final selectTopic = ref.watch(firstSelectedTopicProvider);

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Image.asset(AppImages.damandu),
                    Text('대만두', style: AppFonts.preBold(size: 32, color: AppColors.limeGold(4)),),
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 1.2,
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: selectTopic,
                        icon: const Icon(Icons.arrow_drop_down_outlined),
                        items: AllDropDownComponent.getItems(),
                        isExpanded: true,
                        underline: const SizedBox.shrink(), // 🔥 underline 제거 필수
                        onChanged: (value) {
                          if (value != null && value != selectTopic) {
                            ref.read(firstSelectedTopicProvider.notifier).state = value;
                          } else {
                            FocusScope.of(context).unfocus();
                          }
                        },
                        dropdownColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40),
                    SafeArea(
                      child: GestureDetector(
                        onTap: ()async{

                        },
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                              color: AppColors.limeGold(5),
                              borderRadius: BorderRadius.circular(12)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("추가하기",
                                style: AppFonts.preBold(
                                    size: 20, color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}

class AllDropDownComponent {
  static List<DropdownMenuItem<String>> getItems() {
    return [
      DropdownMenuItem(
        value: '1',
        child: Text('아버지', style:AppFonts.preSemiBold(size: 14, color: AppColors.dark(8))),
      ),
      DropdownMenuItem(
        value: '2',
        child: Text('어머니', style:AppFonts.preSemiBold(size: 14, color: AppColors.dark(8))),
      ),
      DropdownMenuItem(
        value: '3',
        child: Text('계림', style:AppFonts.preSemiBold(size: 14, color: AppColors.dark(8))),
      ),
      DropdownMenuItem(
        value: '4',
        child: Text('성욱', style:AppFonts.preSemiBold(size: 14, color: AppColors.dark(8))),
      ),
    ];
  }
}

