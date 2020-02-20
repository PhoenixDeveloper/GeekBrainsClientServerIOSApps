//
//  UserModel.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 20.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit

struct UserModel {
    let lastName: String
    let firstName: String
    let secondName: String?
    let age: Int
    let photo: UIImage?

    var fullName: String {
        ("\(lastName) \(firstName)\(secondName != nil ? " " + secondName! : "")")
    }
}
