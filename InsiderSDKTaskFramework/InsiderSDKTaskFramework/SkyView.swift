//
//  SkyView.swift
//  InsiderSDKTaskFramework
//
//  Created by Uslu, Teyhan on 18.04.2024.
//

import UIKit

public class SkyView: UIView {
    let manager = SkyManager()
    var viewController: UIViewController?
    
    private lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.delegate = manager
        temp.dataSource = manager
        return temp
    }()
    
    public func setupView(_ viewController: UIViewController) {
        self.addSubview(tableView)
        manager.view = viewController
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    public func addStarInterface(type: StarSize?) {
        manager.addStarInterface(type: type)
        DispatchQueue.main.async { self.tableView.reloadData() }
        self.tableView.reloadData()
    }
}
