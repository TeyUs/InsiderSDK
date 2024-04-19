//
//  SkyManager.swift
//  InsiderSDKTaskFramework
//
//  Created by Uslu, Teyhan on 18.04.2024.
//

import UIKit

class SkyManager: NSObject {
    private var skyList:[Star] = []
    
    public override init() { 
        super.init()
        getFromStorage()
    }
    
    func addStarInterface(type: StarSize?) {
        if let type {
            checkAndAdd(size: type)
        } else {
            skyList.removeAll()
        }
        printInfo(debugMod: true)
        saveData()
    }
    
    private func checkAndAdd(size: StarSize) {
        if skyList.count >= 10 {
            print("Sky is full")
            showAllert()
        } else {
            let star = Star(size: size)
            skyList.append(star)
        }
    }
    
    private func showAllert() {
        let alert = UIAlertController(title: "Sky is full!!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        var rootViewController = UIApplication.shared.firstKeyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private func printInfo(debugMod: Bool = false) {
        if debugMod {
            print("***---***")
            skyList.forEach { star in
                print(star.description)
            }
        }
        print("number of Bright Stars: \(brigtStarCount()), number of all element: \(skyList.count)")
    }
    
    private func brigtStarCount() -> Int {
        skyList.reduce(0) { $1.isbright ? $0 + 1 : $0 }
    }
    
    private func saveData() {
        guard let encodedData = try? JSONEncoder().encode(skyList) else  { return }
        UserDefaults.standard.setValue(encodedData, forKey: "skyList")
    }
    
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
}

extension SkyManager: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skyList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let star = skyList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SkyCell.identifier, for: indexPath) as! SkyCell
        cell.setData(star: star)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

//Source: https://sarunw.com/posts/how-to-get-root-view-controller/
extension UIApplication {
    var firstKeyWindow: UIWindow? {
        // 1
        let windowScenes = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
        // 2
        let activeScene = windowScenes
            .filter { $0.activationState == .foregroundActive }
        // 3
        let firstActiveScene = activeScene.first
        // 4
        let keyWindow = firstActiveScene?.keyWindow
        
        return keyWindow
    }
}
