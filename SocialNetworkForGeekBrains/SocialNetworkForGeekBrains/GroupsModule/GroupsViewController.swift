//
//  GroupsViewController.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 26.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import DTTableViewManager
import Alamofire
import RxSwift
import RxCocoa

class GroupsViewController: UIViewController, DTTableViewManageable {

    var disposeBag = DisposeBag()

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        self.getMyGroup { [unowned self] groups in
            self.manager.memoryStorage.setItems(groups)
        }

        segmentedControl.rx.controlEvent(.valueChanged).subscribe(onNext: { [unowned self] _ in
            switch self.segmentedControl.selectedSegmentIndex {
            case 0:
                self.searchTextField.isEnabled = false
                self.searchTextField.text = ""
                self.getMyGroup { [unowned self] groups in
                    self.manager.memoryStorage.setItems(groups)
                }
            case 1:
                self.manager.memoryStorage.removeAllItems()
                self.searchTextField.isEnabled = true
            default:
                fatalError("Need actions for new segments")
            }
            }).disposed(by: disposeBag)

        searchTextField.rx.text.debounce(.milliseconds(700), scheduler: MainScheduler.instance).subscribe(onNext: { [unowned self] text in
            guard let searchText = text, !searchText.isEmpty else { return }

            self.getSearchGroup(searchText: searchText) { [unowned self] groups in
                self.manager.memoryStorage.setItems(groups)
            }
            }).disposed(by: disposeBag)
    }

    private func registerCells() {
        manager.register(GroupsTableViewCell.self)

        manager.didSelect(GroupsTableViewCell.self) { cell, _, _ in
            cell.setSelected(false, animated: true)
        }
    }

    private func getMyGroup(complition: @escaping ([GroupModel]) -> (Void)) {
        guard let token = Session.storage.token else { return }

        AF.request("https://api.vk.com/method/groups.get?extended=1&access_token=\(token)&v=5.103").responseJSON { json in
            guard let data = json.data else { return }
            do {
                complition((try JSONDecoder().decode(GroupRequestModel.self, from: data)).response.items)
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

    private func getSearchGroup(searchText: String, complition: @escaping ([GroupModel]) -> (Void)) {
        guard let token = Session.storage.token else { return }

        AF.request("https://api.vk.com/method/groups.search?q=\(searchText)&access_token=\(token)&v=5.103").responseJSON { json in
            guard let data = json.data else { return }
            do {
                complition((try JSONDecoder().decode(GroupRequestModel.self, from: data)).response.items)
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
