//
//  DebugDump.swift
//  SwiftEditFramework
//
//  Created by omochimetaru on 2017/09/05.
//

import Foundation


protocol DebugDumpable : CustomDebugStringConvertible {
    func dump() -> DebugDumpValue
}

extension DebugDumpable {
    public var debugDescription: String {
        return dump().description
    }
}

enum DebugDumpValue : DebugDumpable, CustomStringConvertible {
    case string(String)
    case array(Array<DebugDumpable>)
    case dictionary(Array<(String, DebugDumpable)>)
    case object(String, Array<(String, DebugDumpable)>)
    
    func dump() -> DebugDumpValue {
        return self
    }
    
    var description: String {
        let writer = DebugDumpWriter()
        writer.write(value: self)
        return writer.output()
    }
}

fileprivate class DebugDumpWriter {
    init() {
        lines = [""]
        indent = 0
    }
    
    func write(string: String) {
        let n = lines.count
        var line = lines[n-1]
        
        if line.count == 0 {
            line += String.init(repeating: "  ", count: indent)
        }
        
        line += string
        lines[n-1] = line
    }
    
    func writeNewline() {
        lines.append("")
    }
    
    func write(array: Array<DebugDumpable>) {
        if array.count == 0 {
            write(string: "[]")
        } else {
            write(string: "[")
            writeNewline()
            
            pushIndent()
            for x in array {
                write(x)
                writeNewline()
            }
            popIndent()
            
            write(string: "]")
        }
    }
    
    func write(dictionary: Array<(String, DebugDumpable)>) {
        if dictionary.count == 0 {
            write(string: "{}")
        } else {
            write(string: "{")
            writeNewline()
            
            pushIndent()
            for (k, v) in dictionary {
                write(string: k)
                write(string: " => ")
                write(v)
                writeNewline()
            }
            popIndent()
            
            write(string: "}")
        }
    }
    
    func write(object: String, fields: Array<(String, DebugDumpable)>) {
        write(string: object)
        write(string: " ")
        write(dictionary: fields)
    }
    
    func write(_ x: DebugDumpable) {
        write(value: x.dump())
    }
    
    func write(value x: DebugDumpValue) {
        switch x {
        case let .string(x):
            write(string: x)
        case let .array(xs):
            write(array: xs)
        case let .dictionary(xs):
            write(dictionary: xs)
        case let .object(t, xs):
            write(object: t, fields: xs)
        }
    }
    
    func pushIndent() {
        indent += 1
    }
    func popIndent() {
        indent -= 1
    }
    
    func output() -> String {
        return lines.joined(separator: "\n")
    }
    
    var lines: [String]
    var indent: Int
}
