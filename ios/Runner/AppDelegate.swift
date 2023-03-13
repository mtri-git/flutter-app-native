import UIKit
import Flutter
import AVFoundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private let audioChannelName = "audio_player"
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    AudioHandler.register(with: self.flutterEngine!, channelName: audioChannelName)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


@objc class AudioHandler: NSObject, FlutterPlugin {
    private static var channel: FlutterMethodChannel?
    private var player: AVAudioPlayer?

    static func register(with registrar: FlutterPluginRegistrar, channelName: String) {
        channel = FlutterMethodChannel(name: channelName, binaryMessenger: registrar.messenger())
        let instance = AudioHandler()
        registrar.addMethodCallDelegate(instance, channel: channel!)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping @escaping FlutterResult) {
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
