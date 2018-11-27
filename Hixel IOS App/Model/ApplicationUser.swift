//
//  ApplicationUser.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.
//

import Foundation

struct ApplicationUser: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String?
    let portfolio: UserPortfolio?
    
    init(firstName: String, lastName: String, email: String, password: String)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.portfolio = nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case email
        case password
        case portfolio
    }
}
