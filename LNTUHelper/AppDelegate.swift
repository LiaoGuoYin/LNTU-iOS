//
//  AppDelegate.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.registerForRemoteNotifications()
        ViewRouter.notificationCenter.delegate = self
        preparingNotificaion()
        
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    // MARK: Push Notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Constants.notificationToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Trying to get token error: " + error.localizedDescription)
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func preparingNotificaion() {
        let educationNoticeCategories = UNNotificationCategory(identifier: NotificationIdentifiers.notice.rawValue, actions: [], intentIdentifiers: [], options: .customDismissAction)
        ViewRouter.notificationCenter.setNotificationCategories([educationNoticeCategories])
    }
    
    // MARK: Get APNs Notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.notification.request.content.categoryIdentifier {
        case NotificationIdentifiers.notice.rawValue:
            ViewRouter.router.selectedTab = .notice
        case NotificationIdentifiers.grade.rawValue:
            ViewRouter.router.selectedTab = .grade
        default:
            break
        }
        
        // Always call the completion handler when done.
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // If the User is using App when notification coming
        completionHandler(.alert)
    }
    
}
