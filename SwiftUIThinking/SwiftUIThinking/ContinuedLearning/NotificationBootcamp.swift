//
//  NotificationBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/22.
//




// there are three type of local notification

// time based
// calendar based
// location based

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager{
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        let option: UNAuthorizationOptions = [.alert,.sound,.badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: option) { (errSecSuccess, error) in
            if let error = error{
                print("Error: \(error)")
            }else{
                print("success")
            }
        }
    }
    
    func scheduleNotification(){
        
        let content = UNMutableNotificationContent()
        
        content.title = "This is my first notification"
        content.subtitle = "This is description"
        content.sound = .default
        content.badge = 1
        
        //time
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        
        
        //calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour  = 19
//        dateComponents.minute = 18
//        dateComponents.weekday = 2
        
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        
        //location
        let coordinate = CLLocationCoordinate2D(latitude: 40.00,
                                                longitude: 50.00)
        
        
        let region = CLCircularRegion(center: coordinate,
                                      radius: 100,
                                      identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region:region,repeats:true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        
        
        
        //set the schedule noti
        UNUserNotificationCenter.current().add(request)
        
    }
    
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}


struct NotificationBootcamp: View {
    var body: some View {
        VStack(spacing:40){
            Button("request permission"){
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule notification"){
                NotificationManager.instance.scheduleNotification()
            }
            
            Button("Cancel Notification"){
                NotificationManager.instance.cancelNotification()
            }
        }
        
        .foregroundColor(.black)
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
            
        }
    }
}

#Preview {
    NotificationBootcamp()
}
