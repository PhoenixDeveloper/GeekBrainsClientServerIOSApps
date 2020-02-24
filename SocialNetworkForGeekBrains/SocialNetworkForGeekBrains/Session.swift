//
//  Session.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 20.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import Foundation

class Session {
    let storage = Session()

    var token: String?
    var userId: Int?

    private init() {}
}
