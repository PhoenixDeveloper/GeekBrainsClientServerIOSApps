//
//  VKRequestViewController.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 24.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import Alamofire

class VKRequestViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var friendListButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var groupCurrentUserButton: UIButton!
    @IBOutlet weak var groupSearchButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        configureButtons()
    }

    private func configureButtons() {
        friendListButton.titleLabel?.numberOfLines = 0
        friendListButton.titleLabel?.textAlignment = .center

        photoButton.titleLabel?.numberOfLines = 0
        photoButton.titleLabel?.textAlignment = .center

        groupCurrentUserButton.titleLabel?.numberOfLines = 0
        groupCurrentUserButton.titleLabel?.textAlignment = .center

        groupSearchButton.titleLabel?.numberOfLines = 0
        groupSearchButton.titleLabel?.textAlignment = .center
    }
    
    @IBAction func getFriendList(_ sender: UIButton) {
        guard let token = Session.storage.token else { return }

        AF.request("https://api.vk.com/method/friends.get?&access_token=\(token)&v=5.103").responseJSON { data in
            print(data)
        }
    }

    @IBAction func getPhoto(_ sender: UIButton) {
        guard let token = Session.storage.token else { return }

        AF.request("https://api.vk.com/method/photos.getAll?&access_token=\(token)&v=5.103").responseJSON { data in
            print(data)
        }
    }

    @IBAction func getGroupCurrentUser(_ sender: UIButton) {
        guard let token = Session.storage.token else { return }

        AF.request("https://api.vk.com/method/groups.get?&access_token=\(token)&v=5.103").responseJSON { data in
            print(data)
        }
    }

    @IBAction func getGroupWithSearch(_ sender: UIButton) {
        guard let token = Session.storage.token, let searchText = searchTextField.text, !searchText.isEmpty else { return }

        AF.request("https://api.vk.com/method/groups.search?q=\(searchText)&access_token=\(token)&v=5.103").responseJSON { data in
            print(data)
        }
    }
}
