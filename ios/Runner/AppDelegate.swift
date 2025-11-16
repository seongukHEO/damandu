import UIKit
import Flutter
import GoogleMaps  // ✅ ① Google Maps 임포트 추가

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // ✅ ② Google Maps API 키 등록 (여기 본인 키로 교체)
    GMSServices.provideAPIKey("AIzaSyB3ohtt1RS5cEawWSDijkoON427n2OvR9g")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
