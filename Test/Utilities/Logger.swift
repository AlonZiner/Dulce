//
//  Logger.swift
//  Dulce
//
//  Created by admin on 22/12/2020.
//  Copyright © 2020 colman. All rights reserved.
//

import Foundation
class Logger {
    static func LogInfo(info: String) -> () {
        print("Info: " + info)
    }
    
    static func LogWarning(warning: String) -> () {
        print("Warning:" + warning)
    }
    
    static func LogError(error: String) -> () {
        print("Error: " + error)
    }
}
