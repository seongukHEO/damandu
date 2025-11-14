import 'package:damandu/widget/weather_widget.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              WeatherWidget()
            ],
          )
      ),
    );
  }
}
