import 'package:damandu/damandu_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await _initializeServices();

  // 세로 모드만 허용
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(DamanduApp());


  // runApp(
  //   ProviderScope(
  //     overrides: [
  //       authProvider.overrideWithValue(AuthService()),
  //     ],
  //     child: GoldbarrelApp(),
  //   ),
  // );
}

// Future<void> _initializeServices() async {
//   await SharedPreferenceProvider.init();
//   await dotenv.load(fileName: 'assets/etc/.env');
//   await initializeDateFormatting(AppLocale.commonLocale, null);
//
//   // 🚨 여기 수정
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'));
// }
