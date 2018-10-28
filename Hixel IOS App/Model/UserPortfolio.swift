//
//  UserPortfolio.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 14/10/18.
//

import Foundation

struct UserPortfolio : Codable {
    let id: Int?
    let companies: [PortfolioCompany]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case companies
    }
}
