//
//  GroupModel.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 26.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import Foundation

struct GroupModel: Codable {
    let name: String
    let photoURL: String
    let description: String?

    enum CodingKeys: String, CodingKey {
        case
        name,
        photoURL = "photo_200",
        description
    }
}

struct GroupRequestModel: Codable {
    let response: GroupSubRequestModel

    struct GroupSubRequestModel: Codable {
        let count: Int
        let items: [GroupModel]
    }
}
