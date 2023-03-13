import UIKit
import Flutter
import AVFoundation

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let audioChannel = FlutterMethodChannel(name: "audio_player", binaryMessenger: controller.binaryMessenger)
        AudioHandler.register(with: audioChannel)
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}


class AudioHandler: NSObject, FlutterPlugin {
    private static var channel: FlutterMethodChannel?
    private var player: AVAudioPlayer?

    static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "audio_player", binaryMessenger: registrar.messenger())
        let instance = AudioHandler()
        registrar.addMethodCallDelegate(instance, channel: channel!)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "play":
            if let urlString = call.arguments as? String, let url = URL(string: urlString) {
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
        case "stop":
            player?.stop()
            player = nil
            result("success")
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}