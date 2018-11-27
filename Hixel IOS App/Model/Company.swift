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

    private enum CodingKeys: String, CodingKey {
        case identifiers
        case financialDataEntries
        
    }
    
    mutating func calculateGenrealIndicators() ->Double
    {
        // Health = Assets Current/ Liabilities Current
        let health_temp = financialDataEntries[0].ratios["Current Ratio"] ?? 0
        let Strength = financialDataEntries[0].ratios["Interest Coverage"] ?? 0
        let Performance = financialDataEntries[0].ratios["Profit-Margin Ratio"] ?? 0
        let Returns = financialDataEntries[0].ratios["Return-on-Equity Ratio"] ?? 0
        let Safety = financialDataEntries[0].ratios["Current Debt-to-Equity Ratio"] ?? 0
        
        let avg = (health_temp+Strength+Performance+Returns+Safety)/5
        
        health = health_temp
        return avg
    }
    
    /// Function used to calculate the value for Health Indicator
    ///
    /// - Returns: Health Value
    mutating func getHealth() -> Double
    {
        let health_temp = financialDataEntries[0].ratios["Current Ratio"] ?? 0
        health = health_temp
        
        switch health {
        case _ where health < 0.5:
            health=1
        case _ where health > 0.5 && health < 1.0:
            health = 2
        case _ where health > 1.0 && health < 1.5:
            health = 3
        case _ where health > 1.5 && health < 2.0:
            health = 4
        case _ where health > 2.0:
            health = 5
        default:
            health=0
        }
        
        return health
    }
    
    /// Function used to calculate the value for Health Indicator
    ///
    /// - Returns: Health Value
    mutating func getHealth2() -> Double
    {   
        let health_temp = financialDataEntries[1].ratios["Current Ratio"] ?? 0
        health = health_temp
        
        switch health {
        case _ where health < 0.5:
            health=1
        case _ where health > 0.5 && health < 1.0:
            health = 2
        case _ where health > 1.0 && health < 1.5:
            health = 3
        case _ where health > 1.5 && health < 2.0:
            health = 4
        case _ where health > 2.0:
            health = 5
        default:
            health=0
        }
        
        return health
    }
    
    /// Function used to calculate the value for Health Indicator
    ///
    /// - Returns: Health Value
    mutating func getHealth3() -> Double
    {
        let health_temp = financialDataEntries[2].ratios["Current Ratio"] ?? 0
        health = health_temp
        
        switch health {
        case _ where health < 0.5:
            health=1
        case _ where health > 0.5 && health < 1.0:
            health = 2
        case _ where health > 1.0 && health < 1.5:
            health = 3
        case _ where health > 1.5 && health < 2.0:
            health = 4
        case _ where health > 2.0:
            health = 5
        default:
            health=0
        }
        
        return health
    }
    
    /// Function used to calculate the value for Health Indicator
    ///
    /// - Returns: Health Value
    mutating func getHealth4() -> Double
    {
        let health_temp = financialDataEntries[3].ratios["Current Ratio"] ?? 0
        health = health_temp
        
        switch health {
        case _ where health < 0.5:
            health=1
        case _ where health > 0.5 && health < 1.0:
            health = 2
        case _ where health>1.0 && health < 1.5:
            health = 3
        case _ where health > 1.5 && health < 2.0:
            health = 4
        case _ where health > 2.0:
            health = 5
        default:
            health=0
        }
        
        return health
    }
    
    /// Function used to calculate the value for Health Indicator
    ///
    /// - Returns: Health Value
    mutating func getHealth5() -> Double
    {
        let health_temp = financialDataEntries[4].ratios["Current Ratio"] ?? 0
        health = health_temp
        
        switch health {
        case _ where health < 0.5:
            health=1
        case _ where health > 0.5 && health < 1.0:
            health = 2
        case _ where health > 1.0 && health < 1.5:
            health = 3
        case _ where health > 1.5 && health < 2.0:
            health = 4
        case _ where health > 2.0:
            health = 5
        default:
            health=0
        }
        
        return health
    }
    
    /// Function used to calculate the value for Return Indicator
    ///
    /// - Returns: Returns the "Return Indicator"
    mutating func getReturns()-> Double
    {
        let Returns_temp = financialDataEntries[0].ratios["Return-on-Equity Ratio"] ?? 0
        returns = Returns_temp
        
        switch returns {
        case _ where returns < 0.005:
            returns=1
        case _ where returns > 0.005 && returns < 0.1:
            returns = 2
        case _ where returns > 0.1 && returns < 0.2:
            returns = 3
        case _ where returns > 0.2 && returns < 0.25:
            returns = 4
        case _ where returns > 0.25:
            returns = 5
        default:
            returns = 0
        }
        
        return returns
    }
    
    /// Function used to calculate the value for Return Indicator
    ///
    /// - Returns: Returns the "Return Indicator"
    mutating func getReturns2()-> Double
    {
        let Returns_temp = financialDataEntries[1].ratios["Return-on-Equity Ratio"] ?? 0
        returns = Returns_temp
        
        switch returns {
        case _ where returns < 0.005:
            returns=1
        case _ where returns > 0.005 && returns < 0.1:
            returns = 2
        case _ where returns > 0.1 && returns < 0.2:
            returns = 3
        case _ where returns > 0.2 && returns < 0.25:
            returns = 4
        case _ where returns > 0.25:
            returns = 5
        default:
            returns = 0
        }
        
        return returns
    }
    
    /// Function used to calculate the value for Return Indicator
    ///
    /// - Returns: Returns the "Return Indicator"
    mutating func getReturns3()-> Double
    {
        let Returns_temp = financialDataEntries[2].ratios["Return-on-Equity Ratio"] ?? 0
        returns = Returns_temp
        
        switch returns {
        case _ where returns < 0.005:
            returns=1
        case _ where returns > 0.005 && returns < 0.1:
            returns = 2
        case _ where returns > 0.1 && returns < 0.2:
            returns = 3
        case _ where returns > 0.2 && returns < 0.25:
            returns = 4
        case _ where returns > 0.25:
            returns = 5
        default:
            returns = 0
        }
        
        return returns
    }
    
    /// Function used to calculate the value for Return Indicator
    ///
    /// - Returns: Returns the "Return Indicator"
    mutating func getReturns4()-> Double
    {
        let Returns_temp = financialDataEntries[3].ratios["Return-on-Equity Ratio"] ?? 0
        returns = Returns_temp
        
        switch returns {
        case _ where returns < 0.005:
            returns=1
        case _ where returns > 0.005 && returns < 0.1:
            returns = 2
        case _ where returns > 0.1 && returns < 0.2:
            returns = 3
        case _ where returns > 0.2 && returns < 0.25:
            returns = 4
        case _ where returns > 0.25:
            returns = 5
        default:
            returns = 0
        }
        
        return returns
    }
    
    /// Function used to calculate the value for Return Indicator
    ///
    /// - Returns: Returns the "Return Indicator"
    mutating func getReturns5()-> Double
    {
        let Returns_temp = financialDataEntries[4].ratios["Return-on-Equity Ratio"] ?? 0
        returns = Returns_temp
        
        switch returns {
        case _ where returns < 0.005:
            returns=1
        case _ where returns > 0.005 && returns < 0.1:
            returns = 2
        case _ where returns > 0.1 && returns < 0.2:
            returns = 3
        case _ where returns > 0.2 && returns < 0.25:
            returns = 4
        case _ where returns > 0.25:
            returns = 5
        default:
            returns = 0
        }
        
        return returns
    }
    
    
    /// Function used to calculate the value for Safety Indicator
    ///
    /// - Returns: Returns the Safety Indicator
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
    
    /// Function used to calculate the value for Safety Indicator
    ///
    /// - Returns: Returns the Safety Indicator
    mutating func getSafety2() -> Double
    {
        let Safety_temp = financialDataEntries[1].ratios["Current Debt-to-Equity Ratio"] ?? 0
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
    
    /// Function used to calculate the value for Safety Indicator
    ///
    /// - Returns: Returns the Safety Indicator
    mutating func getSafety3() -> Double
    {
        let Safety_temp = financialDataEntries[2].ratios["Current Debt-to-Equity Ratio"] ?? 0
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
    
    /// Function used to calculate the value for Safety Indicator
    ///
    /// - Returns: Returns the Safety Indicator
    mutating func getSafety4() -> Double
    {
        let Safety_temp = financialDataEntries[3].ratios["Current Debt-to-Equity Ratio"] ?? 0
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
    
    /// Function used to calculate the value for Safety Indicator
    ///
    /// - Returns: Returns the Safety Indicator
    mutating func getSafety5() -> Double
    {
        let Safety_temp = financialDataEntries[4].ratios["Current Debt-to-Equity Ratio"] ?? 0
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
    
    /// Function used to calculate the value for Performance Indicator
    ///
    /// - Returns: Returns Performance indicator.
    mutating func getPerformance() -> Double
    {
        let Performance_temp = financialDataEntries[0].ratios["Profit-Margin Ratio"] ?? 0
        performance = Performance_temp
        switch performance {
        case _ where performance < 0.005:
            performance=1
        case _ where performance > 0.005 && performance < 0.10:
            performance = 2
        case _ where performance > 0.1 && performance < 0.2:
            performance = 3
        case _ where performance > 0.2 && performance < 0.25:
            performance = 4
        case _ where performance > 0.25:
            performance = 5
        default:
            performance=0
        }
        
        return performance
    }
    
    /// Function used to calculate the value for Performance Indicator
    ///
    /// - Returns: Returns Performance indicator.
    mutating func getPerformance2() -> Double
    {
        let Performance_temp = financialDataEntries[1].ratios["Profit-Margin Ratio"] ?? 0
        performance = Performance_temp
        switch performance {
        case _ where performance < 0.005:
            performance=1
        case _ where performance > 0.005 && performance < 0.10:
            performance = 2
        case _ where performance > 0.1 && performance < 0.2:
            performance = 3
        case _ where performance > 0.2 && performance < 0.25:
            performance = 4
        case _ where performance > 0.25:
            performance = 5
        default:
            performance=0
        }
        
        return performance
    }
    
    /// Function used to calculate the value for Performance Indicator
    ///
    /// - Returns: Returns Performance indicator.
    mutating func getPerformance3() -> Double
    {
        let Performance_temp = financialDataEntries[2].ratios["Profit-Margin Ratio"] ?? 0
        performance = Performance_temp
        switch performance {
        case _ where performance < 0.005:
            performance=1
        case _ where performance > 0.005 && performance < 0.10:
            performance = 2
        case _ where performance > 0.1 && performance < 0.2:
            performance = 3
        case _ where performance > 0.2 && performance < 0.25:
            performance = 4
        case _ where performance > 0.25:
            performance = 5
        default:
            performance=0
        }
        
        return performance
    }
    
    /// Function used to calculate the value for Performance Indicator
    ///
    /// - Returns: Returns Performance indicator.
    mutating func getPerformance4() -> Double
    {
        let Performance_temp = financialDataEntries[3].ratios["Profit-Margin Ratio"] ?? 0
        performance = Performance_temp
        switch performance {
        case _ where performance < 0.005:
            performance=1
        case _ where performance > 0.005 && performance < 0.10:
            performance = 2
        case _ where performance > 0.1 && performance < 0.2:
            performance = 3
        case _ where performance > 0.2 && performance < 0.25:
            performance = 4
        case _ where performance > 0.25:
            performance = 5
        default:
            performance=0
        }
        
        return performance
    }
    
    /// Function used to calculate the value for Performance Indicator
    ///
    /// - Returns: Returns Performance indicator.
    mutating func getPerformance5() -> Double
    {
        let Performance_temp = financialDataEntries[4].ratios["Profit-Margin Ratio"] ?? 0
        performance = Performance_temp
        switch performance {
        case _ where performance < 0.005:
            performance=1
        case _ where performance > 0.005 && performance < 0.10:
            performance = 2
        case _ where performance > 0.1 && performance < 0.2:
            performance = 3
        case _ where performance > 0.2 && performance < 0.25:
            performance = 4
        case _ where performance > 0.25:
            performance = 5
        default:
            performance=0
        }
        
        return performance
    }
    
    /// Function used to calculate the value for Strength Indicator
    ///
    /// - Returns: Returns Stenght Indicator Value
    mutating func getStrength() ->Double
    {
        let Strength_temp = financialDataEntries[0].ratios["Interest Coverage"] ?? 0
        
        strength = Strength_temp
        
        switch strength {
        case _ where strength < 1.5:
            strength=1
        case _ where strength > 1.5 && strength < 3.0:
            strength = 2
        case _ where strength > 3.0 && strength < 4.5:
            strength = 3
        case _ where strength > 4.5 && strength < 6.0:
            strength = 4
        case _ where strength > 6.0:
            strength = 5
        default:
            strength=0
        }
        
        
        return strength
    }
    /// Function used to calculate the value for Strength Indicator
    ///
    /// - Returns: Returns Stenght Indicator Value
    mutating func getStrength2() ->Double
    {
        let Strength_temp = financialDataEntries[1].ratios["Interest Coverage"] ?? 0
        
        strength = Strength_temp
        
        switch strength {
        case _ where strength < 1.5:
            strength=1
        case _ where strength > 1.5 && strength < 3.0:
            strength = 2
        case _ where strength > 3.0 && strength < 4.5:
            strength = 3
        case _ where strength > 4.5 && strength < 6.0:
            strength = 4
        case _ where strength > 6.0:
            strength = 5
        default:
            strength=0
        }
        
        
        return strength
    }
    /// Function used to calculate the value for Strength Indicator
    ///
    /// - Returns: Returns Stenght Indicator Value
    mutating func getStrengt3() ->Double
    {
        let Strength_temp = financialDataEntries[2].ratios["Interest Coverage"] ?? 0
        
        strength = Strength_temp
        
        switch strength {
        case _ where strength < 1.5:
            strength=1
        case _ where strength > 1.5 && strength < 3.0:
            strength = 2
        case _ where strength > 3.0 && strength < 4.5:
            strength = 3
        case _ where strength > 4.5 && strength < 6.0:
            strength = 4
        case _ where strength > 6.0:
            strength = 5
        default:
            strength=0
        }
        
        
        return strength
    }
    /// Function used to calculate the value for Strength Indicator
    ///
    /// - Returns: Returns Stength Indicator Value
    mutating func getStrength4() ->Double
    {
        let Strength_temp = financialDataEntries[3].ratios["Interest Coverage"] ?? 0
        
        strength = Strength_temp
        
        switch strength {
        case _ where strength < 1.5:
            strength=1
        case _ where strength > 1.5 && strength < 3.0:
            strength = 2
        case _ where strength > 3.0 && strength < 4.5:
            strength = 3
        case _ where strength > 4.5 && strength < 6.0:
            strength = 4
        case _ where strength > 6.0:
            strength = 5
        default:
            strength=0
        }
        
        
        return strength
    }
    
    /// Function used to calculate the value for Strength Indicator
    ///
    /// - Returns: Returns Stenght Indicator Value
    mutating func getStrength5() ->Double
    {
        let Strength_temp = financialDataEntries[4].ratios["Interest Coverage"] ?? 0
        
        strength = Strength_temp
        
        switch strength {
        case _ where strength < 1.5:
            strength=1
        case _ where strength > 1.5 && strength < 3.0:
            strength = 2
        case _ where strength > 3.0 && strength < 4.5:
            strength = 3
        case _ where strength > 4.5 && strength < 6.0:
            strength = 4
        case _ where strength > 6.0:
            strength = 5
        default:
            strength=0
        }
        
        
        return strength
    }
    
    
    /// Function that calculates the score for the company
    ///
    /// - Returns: Score value
    mutating func calculateScore() -> Int
    {
        score = Int(((getHealth()+getSafety()+getReturns()+getPerformance()+getStrength())*4))
        return score
        
    }
}
