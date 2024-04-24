//
//  SkyManager.swift
//  InsiderSDKTaskFramework
//
//  Created by Uslu, Teyhan on 18.04.2024.
//

import UIKit
import UserNotifications

class SkyManager: NSObject {
    private var skyList:[Star] = []
    var reloadView: (() -> ())?
    
    private let notificationIdentifier = "NumberOfStars"
    private let notifyAfter = 5.0
    
    override init() { 
        super.init()
        getFromStorage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), 
                                               name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    /// If app goes to background(willResignActive) this method calls.
    /// Crates a Notification
    @objc func appMovedToBackground() {
        print("=>The application has been sent to the background.\nA notification will be sent after \(notifyAfter) seconds.")
        createNotification()
    }
    
    /// If app comes from background(willEnterForeground) this method calls.
    /// Deletes the Notification
    @objc func appMovedToForeground() {
        print("=>The application has been come to the Foreground.\nThe notification will be removed.")
        
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
    }
    
    /// If user gives a non-nil value of StarSize as type parameter, (if there is more place) SDK adds in Sky.
    /// If parameter is nil, SDK will remove all star from sky.
    /// - Parameters:
    ///   - type: The type of star wanted to add to sky, if nil will remove all star from sky.
    func addStarInterface(type: StarSize?) {
        if let type {
            checkAndAdd(size: type)
        } else {
            skyList.removeAll()
        }
        reloadView?()
        printInfo(debugMod: true)
        saveData()
    }
    
    /// If there is more place in the sky, SDK will be added to the sky, otherwise shows alert.
    private func checkAndAdd(size: StarSize) {
        if skyList.count >= 10 {
            print("Sky is full")
            showAllert()
        } else {
            let star = Star(size: size)
            skyList.append(star)
        }
    }
    
    /// Statically creating a alert.
    private func showAllert() {
        let alert = UIAlertController(title: "Sky is full!!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        var rootViewController = UIApplication.shared.firstKeyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    /// If debugMod is true, additionally prints every elements of SkyList.
    /// Otherwise prints just numbers of lights of bright stars.
    private func printInfo(debugMod: Bool = false) {
        if debugMod {
            print("***---***")
            skyList.forEach { star in
                print(star.description)
            }
        }
        print("number of Bright Stars: \(brigtStarCount()), number of all element: \(skyList.count)")
    }
    
    /// Calculates numbers of lights of bright stars.
    private func brigtStarCount() -> Int {
        skyList.reduce(0) { $1.isbright ? $0 + 1 : $0 }
    }
    
    /// It saves to UserDefaults
    private func saveData() {
        DispatchQueue.global().async { [weak self] in
            guard let encodedData = try? JSONEncoder().encode(self?.skyList) else  { return }
            UserDefaults.standard.setValue(encodedData, forKey: "skyList")
        }
    }
    
    /// It gets from UserDefaults
    private func getFromStorage() {
        if let savedData = UserDefaults.standard.object(forKey: "skyList") as? Data {
            guard let encodedData = try? JSONDecoder().decode([Star].self, from: savedData) else { return }
            print("==============Storage===================")
            encodedData.forEach { star in
                print(star.description)
            }
            skyList = encodedData
        }
    }
    
    deinit {
        createNotification()
    }
    
    /// It creates a notification.
    func createNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Sky"
        notificationContent.subtitle = "number of stars: \(skyList.count)"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notifyAfter , repeats: false)
        
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

/// Creates TableView
extension SkyManager: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let star = skyList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SkyCell.identifier, for: indexPath) as! SkyCell
        cell.setData(star: star)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

extension SkyManager: UNUserNotificationCenterDelegate {
    /// If user comes from notification, SDK will remove all stars from the Sky.
    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        guard notificationIdentifier == response.notification.request.identifier else { return }
        addStarInterface(type: nil)
        reloadView?()
        print("**Came From Notification")
        printInfo(debugMod: true)
    }
}
