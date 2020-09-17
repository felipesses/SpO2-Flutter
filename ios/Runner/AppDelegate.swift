import UIKit
import AVFoundation
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?


  ) -> Bool {


    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "flutter.native/helper", binaryMessenger: controller as! FlutterBinaryMessenger)
    
    channel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void
          in
        guard call.method == "turnOnFlash" else {
          result(FlutterMethodNotImplemented)
          return
        }
        self?.toggleOn(result: result)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

     func toggleOn(result: FlutterResult) {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if ((device?.hasTorch) != nil) {
        do {
            try device?.lockForConfiguration()
            if (device?.torchMode == AVCaptureDevice.TorchMode.on) {
                device!.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device?.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }
            device?.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    }
    

   
}
