//
//  CompanyIdentifiers.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.
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
