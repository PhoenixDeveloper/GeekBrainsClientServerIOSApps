//
//  PhotosViewController.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 26.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import DTTableViewManager
import Alamofire

class PhotosViewController: UIViewController, DTTableViewManageable {

    var imageArray: [PhotoModel] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()

        getData { [unowned self] photos in
            self.manager.memoryStorage.setItems(photos)
        }
    }

    private func registerCells() {
        manager.register(PhotosTableViewCell.self)

        manager.didSelect(PhotosTableViewCell.self) { cell, _, _ in
            cell.setSelected(false, animated: true)
        }
    }
    

    private func getData(complition: @escaping ([PhotoModel]) -> (Void)) {
        guard let token = Session.storage.token else { return }

        AF.request("https://api.vk.com/method/photos.getAll?&access_token=\(token)&v=5.103").responseJSON { json in
            do {
                guard let data = json.data else { return }
                complition((try JSONDecoder().decode(PhotoRequestModel.self, from: data)).response.items)
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
