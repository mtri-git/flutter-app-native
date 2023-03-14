import UIKit
import Flutter
import AVFoundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let audioChannel = FlutterMethodChannel(name: "audio_player",
                                              binaryMessenger: controller.binaryMessenger)
    let player = AVAudioPlayer()
    audioChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // This method is invoked on the UI thread.
      // Handle battery messages.
      switch call.method {
        case "play":
        
            let url = ""
             if let args = call.arguments as? Dictionary<String, Any>,
                let urlString = args["url"] as? String
                url = URL(string: urlString)
            print(url)
            if (url) {
                let session = AVAudioSession.sharedInstance()
                do {
                    try session.setCategory(.playback, mode: .default, options: [])
                    try session.setActive(true)
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.play()
                    result("success")
                } catch {
                    result("error")
                }
            } else {
                result("error")
            }
        case "pause":
            player?.pause()
            result("success")
        case "resume":
            player?.play()
            result("success")
        case "stop":
            player?.stop()
            player = nil
            result("success")
        default:
            result(FlutterMethodNotImplemented)
        }
    })


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}