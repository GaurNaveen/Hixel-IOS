//
//  Company.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.
//

import Foundation

struct Company: Codable {
    let identifiers: CompanyIdentifiers
    let financialDataEntries: [FinancialData]
    
    private enum CodingKeys: String, CodingKey {
        case identifiers
        case financialDataEntries
    }
}
