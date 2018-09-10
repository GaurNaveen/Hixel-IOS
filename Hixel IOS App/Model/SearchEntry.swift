//
//  SearchEntry.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.
//

import Foundation

struct SearchEntry: Codable {
    let ticker: String
    let name: String
    let exchange: String
    
    private enum CodingKeys: String, CodingKey {
        case ticker
        case name
        case exchange
    }
}
