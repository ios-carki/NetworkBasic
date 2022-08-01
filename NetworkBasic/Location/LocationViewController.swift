//
//  LocationViewController.swift
//  NetworkBasic
//
//  Created by Carki on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {
//    static var reuseIdentifier: String = String(describing: LocationViewController.self)
    //저장 프로퍼티
    //LocationViewController.self 메타타입 = > "LocationViewController"
    
    
    //Notification1
    let notificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WebViewController.reuseIdentifier
        
//        //Custom Font
//        for family in UIFont.familyNames {
//            print("======\(family)=======")
//            
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(name)
//            }
//        }
//        
//        

        requestAuthorization()
        
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        sendNotification()
    }
    
    
    //Notification 2. 권한요청
    func requestAuthorization() {
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            
            if success {
                self.sendNotification()
            }
        }
    }
    

    //Notification 3. 권힌 허용한 사용자에게 알림요청(언제?, 어떤 컨텐츠?)
    //iOS 시스템에서 알림을 담당 > 알림 등록
    
    /* 노티(Notification) 주요 정보
     ************************************************************************************
     * - 권한 허용 해야만 알림이 온다
     * - 권한 허용 문구 시스템 적으로 최초 한 번만 뜬다.
     * - 허용 안된 경우 애플 설정으로 직접 유도하는 코드를 구성 해야 한다.
     *
     * - 기본적으로 알림은 포그라운드에서 수신되지 않는다.
     * - 로컬 알림에서 60초 이상 반복 가능 / 갯수 제한 64개 / 커스텀 사운드
     *
     * 1. 뱃지 제거? > 언제 제거하는게 맞을까? 신델리게이트 > sceneDidBecomeActive
     * 2. 노티 제거? > 노티의 유효 기간은(알림센터 내리기에서 알림이 노티) > 카톡(오픈채팅, 단톡) vs 잔디
     *     > 언제 삭제해주는게 맞을까? (appdelegate > 2.노티제거)
     * 3. 포그라운드 수신? >> appdelegate 3. 포그라운드 수신 함수명 : userNotificationCenter
     *
     *                      === +a 생각해보고 예습해보기 ===
     * - 노티는 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면?
     * - 포그라운드 수신 > ex) 카톡 채팅방에 있으면 다른 채팅방의 알림만 오고 현재 채팅방의 알림은 안온다.
     * - 포그라운드 수신, 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 하고 싶다면?
     * - iOS15 > 집중모드 등 5~6개의 우선순위 존재!
     ************************************************************************************
     */
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))입니다"
        notificationContent.body = "저는 따끔따끔 다마고치 입니다. 배고파요"
        notificationContent.badge = 40
        
        //언제 보낼 것인가? 1. 시간 간격 2. 캘린더 3. 위치에 따라 설정 가능
        //시간 간격은 60초 이상 설정해야 반복 가능
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        var dateComponent = DateComponents()
        dateComponent.minute = 6
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        //알림 요청
        //identifier:
        //만약 알림 관리 할 필요 X -> 알림 클릭하면 앱을 켜주는 정도.
        //만약 알림 관리 할 필요 O -> +1, 고유 이름, 규칙 등..
        //\(Date()) -> 중복없이, 타임스템프
        let request = UNNotificationRequest(identifier: "carki", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }

}
