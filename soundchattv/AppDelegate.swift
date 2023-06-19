//
//  AppDelegate.swift
//  soundchattv
//
//  Created by RAJKUMAR on 15/06/23.
//

import Foundation
import UIKit
import AVFAudio

class AppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let audioSession = AVAudioSession.sharedInstance()
    do {
    try audioSession.setCategory(.playback, mode: .moviePlayback)
    }
    catch {
    print("Setting category to AVAudioSessionCategoryPlayback failed.")
    }
    return true
    }
    
}
