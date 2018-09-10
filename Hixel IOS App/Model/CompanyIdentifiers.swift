//
//  CompanyIdentifiers.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import Foundation

struct CompanyIdentifiers: Codable {
    let ticker: String
    let name: String
    let cik: String
    
    private enum CodingKeys: String, CodingKey {
        case ticker
        case name
        case cik
    }
}
