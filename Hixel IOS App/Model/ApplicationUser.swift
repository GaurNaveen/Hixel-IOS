//
//  ApplicationUser.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import Foundation

struct ApplicationUser: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    
    private enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case email
        case password
    }
}
