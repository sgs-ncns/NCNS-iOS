//
//  AppDelegate.swift
//  FCMTest
//
//  Created by 한상혁 on 2022/01/20.
//

import SwiftUI
import Firebase
import UserNotifications
import Amplify
import AWSS3StoragePlugin
import AWSCognitoAuthPlugin

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("앱 포그라운드 실행하는 동안 도착한 알림 처리")
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        if let data1 = userInfo[date1Key] {
            print("data1: \(data1)")
        }
        
        if let data2 = userInfo[data2Key] {
            print("data2: \(data2)")
        }
        
        if let apsData = userInfo[aps] {
            print("apsData: \(apsData)")
        }
        
        completionHandler([[.banner, .badge, .sound]])
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("앱이 APNs에 등록됨을 delegate에 알림")
        Messaging.messaging().apnsToken = deviceToken
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs가 등록 프로세스를 성공적으로 완료할 수 없어서 delegate에게 전송")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("전달된 알림에 대한 사용자의 응답을 처리하도록 요청")
        let userInfo = response.notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID from userNotificationCenter didReceive: \(messageID)")
        }
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("messaging")
        let deviceToken: [String : String] = ["token" : fcmToken ?? ""]
        print("Device token: ", deviceToken)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    let aps = "aps"
    let date1Key = "DATA1"
    let data2Key = "DATA2"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("대리인에게 실행 프로세스가 거의 완료되었고, 앱을 실행할 준비가 되었음을 알림")
        // 파이어 베이스 설정
        FirebaseApp.configure()
        
        // (Messaing: FIRMessaging)의 인스턴스에게 FCM 토큰 새로 고침 및 FCM 직접 채널을 통해 수신된 원격 데이터 메시지 처리하도록 위임
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            print("ios 10 이상 버전")
            // iOS 10 이상 알림 (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            // 취소 승인 옵션, [경고 표시, 배지 업데이트, 소리 재생]
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            
            // 로컬 및 원격 알림이 사용자의 장치로 전달될 때 사용자와 상호작용 할 수 있는 권한 부여 요청
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else { // iOS 10 이하
            // UIUserNotificationSettings는 10버전 이상은 사용하지 않아서 UNNotificationSettings를 사용
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            
            // 사용자에게 알리기 위해 선호하는 옵션 등록
            application.registerUserNotificationSettings(settings)
        }
        //  Apple 푸시 알림 서버스를 통해 원격 알림을 수신하도록 등록
        application.registerForRemoteNotifications()
        
        // Amplify 등록, Auth와 S3 Storage에 접근할 수 있는 플러그인
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.configure()
            print("Amplify configured with storage plugin")
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("가져올 데이터가 있음을 나타내는 원격 알림이 도착했음을 앱에 알린다.")
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print("userInfo: ", userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
}
