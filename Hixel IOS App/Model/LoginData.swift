//
//  LoginData.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.
//

import Foundation

struct LoginData: Codable {
    let email: String
    let password: String
    
    private enum CodingKeys: String, CodingKey {
        case email
        case password
    }
}
