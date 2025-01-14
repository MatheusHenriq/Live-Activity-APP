import Flutter
import ActivityKit
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    let channelName : String = "liveActivityChannel"
    let eventName : String = "LiveActivityEvents"
    
    
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let liveActivityChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        let liveActivityManager = LiveActivityManager()
        liveActivityChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
            case "registerDevice":
                self?.registerDevice(application: application, result: result)
                result(true)
                
            case "requestForNotificationPermission":
                self?.requestNotificationPermissions(result: result)
                result(true)
                break
            case "startLiveActivity":
                liveActivityManager.startLiveActivity(data: call.arguments as? Dictionary<String,Any>)
                result(true)
                break
            case "updateLiveActivity":
                liveActivityManager.updateLiveActivity(data: call.arguments as? Dictionary<String,Any>)
                result(true)
                break
            case "endLiveActivity":
                liveActivityManager.stopLiveActivity()
                result(true)
                break
            default:
                result(FlutterMethodNotImplemented)
            }}
            
            GeneratedPluginRegistrant.register(with: self)
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
        override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                             willPresent notification: UNNotification,
                                             withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            if #available(iOS 14.0, *) {
                completionHandler([.banner, .list, .sound, .badge])
            } else {
                completionHandler([.alert, .sound, .badge])
            }
        }

        override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                             didReceive response: UNNotificationResponse,
                                             withCompletionHandler completionHandler: @escaping () -> Void) {
            let userInfo = response.notification.request.content.userInfo
            completionHandler()
        }

        private func registerDevice(application: UIApplication, result: @escaping FlutterResult) {
            application.registerForRemoteNotifications()
            result("Device Token registration initiated")
        }
    
    private func requestNotificationPermissions(result: @escaping FlutterResult) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                result(FlutterError(code: "PERMISSION_ERROR", message: "Failed to request permissions", details: error.localizedDescription))
                return
            }
                result(granted)
            }
        }
}
