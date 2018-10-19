//
//  FinancialData.swift
//  Hixel IOS App
//
//  Created by Jonah Jeleniewski on 11/9/18.
//

import Foundation

struct FinancialData: Codable {
    let year: Int
    let ratios: [String: Double]
    private enum CodingKeys: String, CodingKey {
        case year
        case ratios
    }
}
