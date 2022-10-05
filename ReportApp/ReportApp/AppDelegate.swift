//
//  AppDelegate.swift
//  ReportApp
//
//  Created by LAP15335 on 15/09/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Configuration Firebase
        FirebaseApp.configure()
        
        // Notification Time
        notificationAlert()
        
        // Check if user already login before
        if #available(iOS 13.0, *) {
        } else {
           checkUser()
        }
        
        return true
    }
    
    func notificationAlert(){
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            guard success else{
                return
            }
        }
        
        
        var tenMinutesBefore = DateComponents()
        tenMinutesBefore.hour = 17
        tenMinutesBefore.minute = 50
        createNotification(title: "Report Daily", body: "Don't forget to report daily for the next 10 minutes :3", date: tenMinutesBefore, identifier: "tenMinutesBefore")
        
        
        var itstime = DateComponents()
        itstime.hour = 18
        itstime.minute = 00
        createNotification(title: "Report Daily", body: "Ting Ting.It's time to report daily! ", date: itstime, identifier: "itstime")
        
        
    }
    
    func createNotification(title: String,body: String, date: DateComponents, identifier: String){
        // Create notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                // handle error
            }
        }
    }
    
    func checkUser(){

        if(UserDefaults.standard.value(forKey: "user")) != nil{
            UserSession.username = UserDefaults.standard.value(forKey: "user") as! String
            let homeViewController = HomeViewController()
            
            let nav = UINavigationController(rootViewController: homeViewController)
            nav.modalPresentationStyle = .fullScreen
        
            let share = UIApplication.shared.delegate as? AppDelegate
            share?.window?.rootViewController = nav
            share?.window?.makeKeyAndVisible()
            
        }
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

