//
//  NewsScreenViewController.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 20.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import DTTableViewManager

class NewsScreenViewController: UIViewController, DTTableViewManageable {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        //manager.memoryStorage.setItems(getMockedData())
    }

    private func registerCell() {
        manager.register(NewsTableViewCell.self)

        manager.didSelect(NewsTableViewCell.self) { cell, _, _ in
            cell.setSelected(false, animated: true)
        }
    }
}
