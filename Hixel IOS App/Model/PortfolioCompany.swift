//
//  PortfolioCompany.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 14/10/18.
//

import Foundation

struct PortfolioCompany : Codable {
    let id : Int?
    let ticker : String
    
    private enum CodingKeys : String, CodingKey {
        case id
        case ticker
    }
}
