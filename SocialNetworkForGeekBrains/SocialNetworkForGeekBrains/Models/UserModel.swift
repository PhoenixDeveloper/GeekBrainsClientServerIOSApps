//
//  UserModel.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 20.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit

struct UserModel: Codable {
    let lastName: String
    let firstName: String
    let secondName: String?
    let birthday: String?
    let photoURL: String?

    var fullName: String {
        ("\(lastName) \(firstName)\(secondName != nil ? " " + secondName! : "")")
    }

    var age: Int? {
        return nil
    }

    enum CodingKeys: String, CodingKey {
        case
        lastName = "last_name",
        firstName = "first_name",
        secondName = "nickname",
        birthday = "bdate",
        photoURL = "photo_400_orig"
    }
}

struct FriendsRequestModel: Codable {
    let response: FriendsSubRequestModel

    struct FriendsSubRequestModel: Codable {
        let count: Int
        let items: [UserModel]
    }
}
