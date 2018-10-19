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
  //  var score :Int? = nil
    var score = 60
    var health = 0.0
    var returns = 0.0
    var safety = 0.0
    var performance = 0.0
    var strength = 0.0
   // var generalIndicators : [Double]
    private enum CodingKeys: String, CodingKey {
        case identifiers
        case financialDataEntries
        
    }
    
    mutating func calculateGenrealIndicators() ->Double
    {
        // Health = Assets Current/ Liabilities Current
        let health_temp = financialDataEntries[0].ratios["Current Ratio"] ?? 0
        let Strength = financialDataEntries[0].ratios["Interest Coverage"] ?? 0
        let Performance = financialDataEntries[0].ratios["Return-on-Equity Ratio"] ?? 0
        let Returns = financialDataEntries[0].ratios["Dividend Yield"] ?? 0
        let Safety = financialDataEntries[0].ratios["Current Debt-to-Equity Ratio"] ?? 0
        
        let avg = (health_temp+Strength+Performance+Returns+Safety)/5
        
        health = health_temp
        //print("Strength",health)
        //print("health ",health)
        //generalIndicators?.Health = health!
        
        return avg
    }
    
    mutating func getHealth() -> Double
    {
        let health_temp = financialDataEntries[0].ratios["Current Ratio"] ?? 0
        health = health_temp
        
        switch health {
        case _ where health<0.5:
            health=1
        case _ where health>0.5 && health < 1.0:
            health = 2
        case _ where health>1.0 && health<1.5:
            health = 3
        case _ where health>1.5 && health<2.0:
            health = 4
        case _ where health>2.0:
            health = 5
        default:
            health=0
        }
        
        return health
    }
    
    mutating func getReturns()-> Double
    {
        let Returns_temp = financialDataEntries[0].ratios["Dividend Yield"] ?? 0
        returns = Returns_temp
        
        switch returns {
        case _ where returns<0.005:
            returns=1
        case _ where returns>0.005 && returns < 0.01:
            returns = 2
        case _ where returns>0.01 && returns<0.05:
            returns = 3
        case _ where returns>0.05 && returns<0.10:
            returns = 4
        case _ where returns>0.10:
            returns = 5
        default:
            returns=0
        }
        
        return returns
        
        
    }
    
    mutating func getSafety() -> Double
    {
        let Safety_temp = financialDataEntries[0].ratios["Current Debt-to-Equity Ratio"] ?? 0
        safety = Safety_temp
        
        switch safety {
        case _ where safety>10.0:
            safety=1
        case _ where safety>4.0 && safety < 10.0:
            safety = 2
        case _ where safety>1.5 && safety<4.0:
            safety = 3
        case _ where safety>0.5 && safety<1.5:
            safety = 4
        case _ where safety<0.5:
            safety = 5
        default:
            safety=0
        }
        
        return safety
    }
    
    mutating func getPerformance() -> Double
    {
        let Performance_temp = financialDataEntries[0].ratios["Return-on-Equity Ratio"] ?? 0
        performance = Performance_temp
        switch performance {
        case _ where performance<0.005:
            performance=1
        case _ where performance>0.005 && performance < 0.10:
            performance = 2
        case _ where performance>0.1 && performance<0.2:
            performance = 3
        case _ where performance>0.2 && performance<0.25:
            performance = 4
        case _ where performance>0.25:
            performance = 5
        default:
            performance=0
        }
        
        return performance
    }
    
    mutating func getStrength() ->Double
    {
        let Strength_temp = financialDataEntries[0].ratios["Interest Coverage"] ?? 0
        
        strength = Strength_temp
        
        switch strength {
        case _ where strength<1.5:
            strength=1
        case _ where strength>1.5 && strength < 3.0:
            strength = 2
        case _ where strength>3.0 && strength<4.5:
            strength = 3
        case _ where strength>4.5 && strength<6.0:
            strength = 4
        case _ where strength>6.0:
            strength = 5
        default:
            strength=0
        }
        
        
        return strength
    }
}
