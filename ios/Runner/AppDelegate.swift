import UIKit
import Flutter
import AudioPlayer

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = windows?.rootViewController as! FlutterViewController
    let audioChanel = FlutterMethodChannel(name: "audio_player", binaryMessenger: controller.binaryMessenger)
    audioChanel.setMethodCallHandler({weak self}
    (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      
      audioChanel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // This method is invoked on the UI thread.
      // guard call.method == "play" else {
      //   result(FlutterMethodNotImplemented)
      //   return
      // }
      switch call.method {
      case "play":
          let url = call.arguments("url")
          AudioPlayer.play(url)
          result(null)
      case "pause":
        AudioPlayer.pause()
          result(null)

      case "stop":
        AudioPlayer.stop()
        result(null)

      default:
        result(FlutterMethodNotImplemented)
        
      }
    })


    )
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
