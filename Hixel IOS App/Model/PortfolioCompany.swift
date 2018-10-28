//
//  PortfolioCompany.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 14/10/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
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
