import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Widget imageSlider(path, index){
//   return Container(
//     width: double.infinity,
//     color: Colors.grey,
//     child: Image.network(path, fit: BoxFit.cover,),
//   );
// }

Widget imageSlider( path, index){
  return Container(
    width: double.infinity,
    color: Colors.grey,
    child: Image.network(path, fit: BoxFit.cover,),
  );
}

Widget imageIndicator(int imageLength, int activeIndex){
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imageLength,
        effect: JumpingDotEffect(
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: Colors.white,
          dotColor: Colors.white.withOpacity(0.6)
        ),
    ),
  );
}

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _dismissKeyboard();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _dismissKeyboard();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _dismissKeyboard();
  }

  void _dismissKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}