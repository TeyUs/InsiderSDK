//
//  SkyManager.swift
//  InsiderSDKTaskFramework
//
//  Created by Uslu, Teyhan on 18.04.2024.
//

import UIKit

class SkyManager: NSObject {
    private var skyList:[Star] = []
    public weak var view: UIViewController?
    
    public override init() { }
    
    func addStarInterface(type: StarSize?) {
        if let type {
            checkAndAdd(size: type)
        } else {
            skyList.removeAll()
        }
        printAllList()
    }
    
    private func checkAndAdd(size: StarSize) {
        if skyList.count >= 10 {
            print("Sky is full")
            view?.showAllert()
        } else {
            let star = Star(size: size)
            skyList.append(star)
        }
    }
    
    private func printAllList() {
        print("***---***")
        skyList.forEach { star in
            print(star.description)
        }
        print("number of Bright Stars: \(brigtStarCount()), number of all element: \(skyList.count)")
    }
    
    private func brigtStarCount() -> Int {
        skyList.reduce(0) { $1.isbright ? $0 + 1 : $0 }
    }
}

extension SkyManager: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skyList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let star = skyList[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = star.description
        return cell
    }
}
