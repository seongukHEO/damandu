import 'package:damandu/damandu_app.dart';
import 'package:damandu/provider/shared_preference_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart'; // ✅ 딱 이거 하나만

import 'common/app_locale.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/app_locale.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeServices();
  // 세로 모드만 허용
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ProviderScope(
      overrides: [

      ],
      child: DamanduApp(),
    ),
  );


}

Future<void> _initializeServices() async {
   await SharedPreferenceProvider.init();
  // await dotenv.load(fileName: 'assets/etc/.env');
  await initializeDateFormatting('ko_KR', null); // ✅ 매개변수 이름 없이


  // 🚨 여기 수정
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'));
}
