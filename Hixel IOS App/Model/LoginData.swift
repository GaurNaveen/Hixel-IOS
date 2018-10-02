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
    
    init(email : String, password : String) {
        self.email = email
        self.password = password
    }
    
    private enum CodingKeys: String, CodingKey {
        case email
        case password
    }
}
