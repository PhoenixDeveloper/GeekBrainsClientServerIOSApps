//
//  FriendListViewController.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 20.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import DTTableViewManager
import RxSwift
import RxCocoa

class FriendListViewController: UIViewController, DTTableViewManageable {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        manager.memoryStorage.setItems(getMockedData())
    }

    private func registerCells() {
        manager.register(FriendTableViewCell.self)

        manager.configure(FriendTableViewCell.self) { cell, _, indexPath in
            cell.deleteFromFriendsButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] _ in
                self.manager.memoryStorage.removeItems(at: [indexPath])
                self.tableView.reloadData()
            }).disposed(by: cell.disposeBag)
        }

        manager.didSelect(FriendTableViewCell.self) { cell, _, _ in
            cell.setSelected(false, animated: true)
        }
    }

    private func getMockedData() -> [UserModel] {
        let user1 = UserModel(lastName: "Беленко",
                              firstName: "Михаил",
                              secondName: "Олегович",
                              age: 23,
                              photo: UIImage(imageLiteralResourceName: "userPhoto1"))

        let user2 = UserModel(lastName: "Иванов",
                              firstName: "Петр",
                              secondName: nil,
                              age: 27,
                              photo: nil)

        return [user1, user2]
    }
}
