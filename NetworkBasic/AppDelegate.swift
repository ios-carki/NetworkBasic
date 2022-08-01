//
//  AppDelegate.swift
//  NetworkBasic
//
//  Created by Carki on 2022/07/27.
//

import UIKit


//UNUserNotificationCenter > 세부적인 것 제거
@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //2. 노티 제거
        //removeAllDeliveredNotifications > 알림센터에 쌓인 노티 제거(카카오톡과 비슷)
        //pendgin -> 이미 전달된것이랑, 온 것도 날림 ex) 알람
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        UNUserNotificationCenter.current().delegate = self
        //>>UNUserNotificationCenter.current().delegate = self
        //밑에 함수가 실행되는 권한 > func userNotificationCenter
        return true
    }
    
    //포그라운드 상태에서 안보이게 됨
    // 3. 포그라운드 수신!
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .badge, .sound])
        //iOS 14 list, banner < - > alert (iOS14 이상부터 alert가 list, banner로 나뉨)
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
    
    //앱이 종료된지 아는 방법
    //항상 호출되는 것은 아니다
//    func applicationWillTerminate(_ application: UIApplication) {
//        print("앱 꺼짐")
//    }


}

