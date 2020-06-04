//
//  Tools.swift
//  MulchCalculator
//
//  Created by Phan Đăng on 5/4/20.
//  Copyright © 2020 Phan Đăng. All rights reserved.
//

import Foundation
class Tools {
    
    //Test valid input
    static func textDecimalValid(inputText:String) -> Int {
        
        if inputText == "" {
            return -2
        }
        
        let inputTextRemoveSpace = inputText.stringByRemovingWhitespaces
        let inputTextRemoveDot = inputTextRemoveSpace
        
        guard let doubleIndex = Double(inputTextRemoveDot) else {
            return 0
        }
        if doubleIndex < 0 || doubleIndex > 9999999999 {
            if doubleIndex < 0 {
                return 1
            }else {
                return 2
            }
        }
        
        return -1
    }
    
    static func textIntValid(inputText:String) -> Int {
        
        if inputText == "" {
            return -2
        }
        
        let inputTextRemoveSpace = inputText.stringByRemovingWhitespaces
        let inputTextRemoveDot = inputTextRemoveSpace
        
        guard let IntIndex = Int(inputTextRemoveDot) else {
            return 0
        }
        if IntIndex < 0 || IntIndex > 999999999 {
            if IntIndex < 0 {
                return 1
            }else {
                return 2
            }
        }
        
        return -1
    }
    
    static func textNumberValid(inputText:String) -> Int {
        
        if inputText == "" {
            return -2
        }
        
        let inputTextRemoveSpace = inputText.stringByRemovingWhitespaces
        let inputTextRemoveDot = inputTextRemoveSpace
        
        guard let doubleIndex = Double(inputTextRemoveDot) else {
            return 0
        }
        if doubleIndex < -9999999999 || doubleIndex > 9999999999 {
            if doubleIndex < -9999999999 {
                return 1
            }else {
                return 2
            }
        }
        
        return -1
    }
    
    static func changeToCurrency(moneyStr:Double) ->String? {
        let number = moneyStr
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter.string(from: NSNumber(value: number))
    }
    
    static func toMForGap(value: Double, defaultString: String)->Double {
        
        let defaults = UserDefaults.standard
        var result = 0.0
        print(defaults.integer(forKey: defaultString))
        if defaults.integer(forKey: defaultString) == 1 {
           result = value * 0.0254 //in
        }else if defaults.integer(forKey: defaultString) == 2 {
            result = value * 0.3048 //ft
        }else if defaults.integer(forKey: defaultString) == 3 {
            result = value * 0.9144 //yd
        }else if defaults.integer(forKey: defaultString) == 4 {
            result = value * 0.001 //mm
        }else if defaults.integer(forKey: defaultString) == 5 {
            result = value * 0.01 //cm
        }else if defaults.integer(forKey: defaultString) == 6{
            result = value * 1 //m
        }
        
        return result
    }
    
    
    static func toM(value: Double, defaultString: String)->Double {
        
        let defaults = UserDefaults.standard
        var result = 0.0
        print(defaults.integer(forKey: defaultString))
        if defaults.integer(forKey: defaultString) == 1 {
           result = value * 0.0254 //in
        }else if defaults.integer(forKey: defaultString) == 2 {
            result = value * 0.3048 //ft
        }else if defaults.integer(forKey: defaultString) == 3 {
            result = value * 0.9144 //yd
        }else if defaults.integer(forKey: defaultString) == 4 {
            result = value * 0.01 //cm
        }else if defaults.integer(forKey: defaultString) == 5 {
            result = value * 1 //m
        }
        
        return result
    }
    
    static func toM3(value: Double, defaultString: String)->Double {
        
        let defaults = UserDefaults.standard
        var result = 0.0
        print(defaults.integer(forKey: defaultString))
        if defaults.integer(forKey: defaultString) == 1 {
           result = value * 1 //M3
        }else if defaults.integer(forKey: defaultString) == 2 {
            result = value * 0.0283168466 //Ft3
        }else if defaults.integer(forKey: defaultString) == 3 {
            result = value * 0.7646 //Yd3
        }else if defaults.integer(forKey: defaultString) == 4 {
            result = value * 0.001 //Liters
        }
        
        return result
    }
    
    static func toM2(value: Double, defaultString: String)->Double {
        
        let defaults = UserDefaults.standard
        var result = 0.0
        
        if defaults.integer(forKey: defaultString) == 1 {
            result = value * 0.00064516 //in
        }else if defaults.integer(forKey: defaultString) == 2 {
            result = value * 0.09290304 //ft
        }else if defaults.integer(forKey: defaultString) == 3 {
            result = value * 0.83612736 //yd
        }else if defaults.integer(forKey: defaultString) == 4 {
            result = value * 0.0001 //cm
        }else if defaults.integer(forKey: defaultString) == 5 {
            result = value * 1  //m
        }
        
        return result
    }
    
    static func cmToMoney(cmSquareValue: Double,priceValue: Double,per:Int, defaultString: String)->Double {
        
        let defaults = UserDefaults.standard
        var result = 0.0
        
        if defaults.integer(forKey: defaultString) == 1 {
            result = (cmSquareValue * priceValue * 10.7639104 * 0.0001)/Double(per)
        }else if defaults.integer(forKey: defaultString) == 2 {
            result = (cmSquareValue * priceValue * 1.19599005 * 0.0001)/Double(per)
        }else if defaults.integer(forKey: defaultString) == 3 {
            result = (cmSquareValue * priceValue  * 0.0001)/Double(per)
        }
        
        return round(result * 100) / 100
    }
    
    
    static func checkTriangleValid(aToCm: Double, bToCm:Double, cToCm:Double)->Bool {
        if aToCm + bToCm > cToCm && bToCm + cToCm > aToCm && aToCm + cToCm > bToCm {
            return true
        }else {
            return false
        }
    }
    
}

extension String {
    var stringByRemovingWhitespaces: String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension Decimal {
    mutating func round(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) {
        var localCopy = self
        NSDecimalRound(&self, &localCopy, scale, roundingMode)
    }

    func rounded(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) -> Decimal {
        var result = Decimal()
        var localCopy = self
        NSDecimalRound(&result, &localCopy, scale, roundingMode)
        return result
    }
}
