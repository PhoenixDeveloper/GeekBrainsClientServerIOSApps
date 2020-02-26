//
//  PhotoModel.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 26.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import Foundation

struct PhotoModel: Codable {
    let sizes: [SizesModel]

    struct SizesModel: Codable {
        let type: String
        let url: String
        let width: Int
        let height: Int
    }
}

struct PhotoRequestModel: Codable {
    let response: PhotoSubRequestModel

    struct PhotoSubRequestModel: Codable {
        let count: Int
        let items: [PhotoModel]
    }
}
