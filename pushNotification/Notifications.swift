//
//  Notification.swift
//  pushNotification
//
//  Created by macbook on 09.08.2022.
//

import UserNotifications



/////////////////////////
//создаем класс для упарвления нотификацией
class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    //командный центр
    let notificationCenter = UNUserNotificationCenter.current()
    
    func userRequest() {//запрос разрешения от пользователя
        let option: UNAuthorizationOptions = [ .alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: option) {razreshenie, error in
            if !razreshenie {
                print("polzovatel otklonil razreshenie")
            }
        }
        
    }
    
//функция запуска нотификации
    
    func showNotification(notificationTitle: String, time: TimeInterval) {
        //клнтент содержимого уведомления
        let content = UNMutableNotificationContent()
        content.title = notificationTitle
        content.body = "text dlya tela notificatcii"
        content.sound = .default
        content.badge = 1
        let useraction = "useraction"
        //индентификатор категории (как индентификатор ячейки таблицы)
        content.categoryIdentifier = useraction
  
        //варианты срабатывания тригера:
        
        //сработало через 5 секунд
        let triggerTime = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        
        
        //тригер срабатывания по конретной дате(карентдате)
//        let curentDate = Date().addingTimeInterval(10)//к текущей дате + 10 секунд для примера
        
  //      let curentDate = dataPicerVirew.date() при использованиедатапикервью
        
//        let curentDate =
//        var dateComponents = DateComponents()
//        dateComponents.weekday = 3  // Wednesday
//        dateComponents.hour = 11    // 11:00
//        // Create the trigger as a repeating event.
//        let calendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        
        //        let targetDate = Calendar.current.dateComponents([
//            .day, .month, .year,.hour, .minute, .second], from: curentDate)
//        let triggerDate = UNCalendarNotificationTrigger(dateMatching: targetDate, repeats: false)
        
        
        
        //индентификатор нотификации (как индентификатор ячейки таблицы)
        let indentificator = "localNotification"
        //создаем запрос нотификации
        let request = UNNotificationRequest(identifier: indentificator, content: content, trigger: triggerTime)
        
        //добавляем наш запрос в центр нотификации
        notificationCenter.add(request) { error in
            if let error = error {
                print(error.localizedDescription) //выводит описание ошибки
            }
        }
        //добавляем экшины к пушам
        
        //повторение
        let snoozeAction = UNNotificationAction(identifier: "snooze", title: "snooze", options: [])
        //удаление
        let deleteAction = UNNotificationAction(identifier: "delete", title: "delete", options: [.destructive])
        //добавляем экшины в массив действий пуша
        let category = UNNotificationCategory(identifier: useraction, actions: [snoozeAction, deleteAction], intentIdentifiers: [], options: [])
  //добавляем все это в нотификейшнцентр
        notificationCenter.setNotificationCategories([category])
    }
    
 
    
    
    
    
    //функция которая отображает нотификацию при открытом приложении
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    //функция реакции на нажатие на пуш уведомление
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
            
        case UNNotificationDismissActionIdentifier:
            print("dismis action")
        case UNNotificationDefaultActionIdentifier:
            print("default")
        case "snooze":
            print("snooze")
            showNotification(notificationTitle: "повторение", time: 3)
        case "delete":
            print("delete")
            
        default:
            print("ничего")
        }
        completionHandler()
        
        
    }
    
    
}













