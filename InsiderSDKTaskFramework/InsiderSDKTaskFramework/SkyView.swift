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
    
    public func addStarInterface(type: StarSize?) {
        manager.addStarInterface(type: type)
        self.tableView.reloadData()
    }
}
