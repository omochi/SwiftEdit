//
//  Error.swift
//  SwiftEditFramework
//
//  Created by omochimetaru on 2017/09/05.
//

import Foundation

internal struct Error : Swift.Error, CustomStringConvertible {
    public init(_ message: String) {
        self.message = message
    }
    
    public var message: String
    
    public var description: String {
        return "Error(\(message))"
    }
}
