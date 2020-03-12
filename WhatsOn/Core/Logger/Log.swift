//
//  Log.swift
//  What'sOn
//
//  Created by Maxime Maheo on 12/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct Log {
    
    private static func convert(values: Any..., file: String, function: String) -> String {
        let message = values
            .map { "\($0)" }
            .joined(separator: ", ")
        
        var fileName = ""
        
        if
            let startIndex = file.lastIndex(of: "/"),
            let endIndex = file.firstIndex(of: ".") {
            fileName = String(file[file.index(startIndex, offsetBy: 1)..<endIndex])
        }
        
        return "\(fileName), \(function) -> \(message)"
    }
    
    static func info(_ values: Any..., file: String = #file, function: String = #function) {
        #if DEBUG
        print("ℹ️ \(convert(values: values, file: file, function: function))")
        #endif
    }
    
    static func warning(_ values: Any..., file: String = #file, function: String = #function) {
        #if DEBUG
        print("⚠️ \(convert(values: values, file: file, function: function))")
        #endif
    }
    
    static func error(_ values: Any..., file: String = #file, function: String = #function) {
        #if DEBUG
        print("‼️ \(convert(values: values, file: file, function: function))")
        #endif
    }
    
}
