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
import Alamofire

class FriendListViewController: UIViewController, DTTableViewManageable {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        getData { [unowned self] data in
            self.manager.memoryStorage.setItems(data)
        }
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

    private func getData(complition: @escaping ([UserModel]) -> (Void)) {
        guard let token = Session.storage.token else { return }

        AF.request("https://api.vk.com/method/friends.get?fields=nickname,bdate,photo_400_orig&access_token=\(token)&v=5.103").responseJSON { json in
            do {
                guard let data = json.data else { return }
                complition((try JSONDecoder().decode(FriendsRequestModel.self, from: data)).response.items)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
    }
}
