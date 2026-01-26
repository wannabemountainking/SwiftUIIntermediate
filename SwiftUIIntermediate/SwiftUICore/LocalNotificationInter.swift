//
//  LocalNotificationInter.swift
//  SwiftUIIntermediate
//
//  Created by YoonieMac on 1/31/26.
//

import SwiftUI
import UserNotifications


class NotificationManager {
    static let instance = NotificationManager() // 인스턴스 생성... 이거 싱글톤인가? 그런데 private init() 이 없네
    
    func requestAuthoriztion() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        // UserNotification 접근
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error)  in
            if let error {
                print("에러: \(error.localizedDescription)")
            } else {
                print("성공")
            }
        }
    }
    
    func scheduleNotification() {
        // 1. notification 내용 설정: 제목, 소리 벳지 등 어떤 내용으로 설정할 것인가
        let content = UNMutableNotificationContent()
        content.title = "Local Notification 테스트 1"
        content.subtitle = "앱 알람 테스트 중입니다"
        content.sound = .default
        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        /*
         2. Trigger 2가지 종류
            - 시간 기준: Interval 몇 초 뒤에 울릴 것인지 딜레이 설정. repeats 반복 여부 설정 (최소 1분 이어야지 반복이 가능함)
            - 날짜 기준: DateMatching 이것은 DateComponent의 기준에 맞는 알림임
         */
        // 시간 기준 Trigger
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
        
        // 날짜 기준 Trigger
        var dateComponents = DateComponents()
        dateComponents.hour = 21 // hour를 24시간 기준으로 여기서는. 오후 9시
        dateComponents.minute = 33
//        dateComponents.weekday = 0  //=> 1은 일요일, 6은 금요일이 됨
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // 3. 설정한 값을 NotificationCenter에 요청하기
        let request = UNNotificationRequest(
            identifier: UUID().uuidString, // 각각의 request ID 값 String을 UUID()의 문자열 값으로 설정
            content: content,
            trigger: calendarTrigger
        )
        
        // 4. UNUserNotificationCenter에 설정한 값을 추가
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification()  {
        //1. pending notification은 trigger 상에서 만족된 조건이 되어도 더 이상 notification 되지 않게 하기
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        //2. delivered Notification 아이폰 상태바를 내렸을 때 남아 있는 notification 없내는 것
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationInter: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack(spacing: 40) {
            Button {
                // Action
                NotificationManager.instance.requestAuthoriztion()
            } label: {
                Text("권한 요청하기")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Button {
                // Action
                NotificationManager.instance.scheduleNotification()
            } label: {
                Text("Time Notification")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Button {
                // Action
                NotificationManager.instance.scheduleNotification()
            } label: {
                Text("Calendar Notification")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Button {
                // Action
                NotificationManager.instance.scheduleNotification()
            } label: {
                Text("Notification 취소하기")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        } //:VSTACK
        // scene이 온전히 다 나타날 때(앱을 다시 보면) Badge 0으로 초기화됨
        .onChange(of: scenePhase) { newValue in
            if newValue == .active {
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
    }//: body
}

#Preview {
    LocalNotificationInter()
}
