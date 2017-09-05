//
//  OptionalHandling.swift
//  SwiftEditFramework
//
//  Created by omochimetaru on 2017/09/05.
//

import Foundation

internal func nonNil<T>(_ x: T?, _ reason: String) throws -> T {
    guard let x = x else {
        throw Error("unexcepted nil: \(reason)")
    }
    return x
}
