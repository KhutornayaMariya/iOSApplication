//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by m.khutornaya on 05.12.2022.
//

import Foundation
import UserNotifications
import UIKit

final class LocalNotificationsService: NSObject {

    func registeForLatestUpdatesIfPossible() {
        let notificationCenter = UNUserNotificationCenter.current()
        registerCategories()

        notificationCenter.requestAuthorization(options: [.sound, .badge, .provisional]) { granted, _ in
            if granted {
                self.scheduleNotification()
                print("Доступ к уведомлениям получен")
            }
            else {
                print("Доступ не получен")
            }
        }
    }

    private func scheduleNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = "Посмотрите последние обновления"
        content.body = "Пока вас не было появилось много нового"
        DispatchQueue.main.async {
            content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
        }
        content.sound = .default
        content.categoryIdentifier = "updates"

        var dateComponents = DateComponents()
        dateComponents.hour = 19
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        notificationCenter.add(request)
    }

    private func registerCategories() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self

        let positiveAction = UNNotificationAction(identifier: "show_more", title: "Показать больше", options: .foreground)
        let negativeAction = UNNotificationAction(identifier: "cancel", title: "Отметить прочитанным", options: .destructive)

        let category = UNNotificationCategory(identifier: "updates",
                                              actions: [positiveAction, negativeAction],
                                              intentIdentifiers: [],
                                              options: [])

        notificationCenter.setNotificationCategories([category])
    }
}

extension LocalNotificationsService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        UIApplication.shared.applicationIconBadgeNumber -= 1

        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("нажата сама нотификация")
        case "show_more":
            print("show_more")
        case "cancel":
            print("cancel")
        default:
            print("default")
        }

        completionHandler()
    }
}
