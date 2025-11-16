import 'package:flutter/material.dart';

import '../component/textField_component.dart';


class CalculatorWidget extends StatelessWidget {
  const CalculatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              // TextFieldComponent(
              //   controller: modifyUserNickname,
              //   onChanged: (text) {
              //     ref.read(userNicknameControllerProvider.notifier).setUserNickname(text);
              //   },
              //   limitedLength: 20,
              //   hintText: "닉네임을 입력해주세요",
              // ),
            ],
          )
      ),
    );
  }
}
