import 'package:damandu/router.dart';
import 'package:damandu/widget/home/time_widget.dart';
import 'package:damandu/widget/home/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/shared_preference_keys.dart';
import '../provider/shared_preference_provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WeatherWidget(),
                  const SizedBox(height: 20),
                  TimeWidget(key: ValueKey('clock1')),
                ],
              ),
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            //context.push(RoutePath.addQuestion);
            final sharedPreferences = await SharedPreferences.getInstance();
            final userUid = sharedPreferences.getString(SharedPreferenceKeys.userUid);
            debugPrint('userUid 저장됨 : ${userUid}');
          }
      ),
    );
  }
}
