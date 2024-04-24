//
//  SkyView.swift
//  InsiderSDKTaskFramework
//
//  Created by Uslu, Teyhan on 18.04.2024.
//

import UIKit

public class SkyView: UIView {
    let manager = SkyManager()
    
    private lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.delegate = manager
        temp.dataSource = manager
        temp.register(SkyCell.self, forCellReuseIdentifier: SkyCell.identifier)
        return temp
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        manager.reloadView = self.tableView.reloadData
    }
    
    private func setupView() {
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    /// If user gives a non-nil value of StarSize as type parameter, (if there is more place) SDK adds in Sky.
    /// If parameter is nil, SDK will remove all star from sky.
    /// - Parameters:
    ///   - type: The size of star wanted to add to sky, if nil will remove all star from sky.
    public func addStarInterface(type: StarSize?) {
        manager.addStarInterface(type: type)
    }
}
