//
//  ASTNode.swift
//  SwiftEditFramework
//
//  Created by omochimetaru on 2017/09/05.
//

import Foundation
import SourceKittenFramework

public class ASTNode : DebugDumpable {
    public required init() {
    }
    
    public var children: [ASTNode] {
        return _children
    }
    
    public func addChild(_ x: ASTNode) {
        _children.append(x)
    }
    
    internal func dump() -> DebugDumpValue {
        let name = String(describing: type(of: self))
        var fields = [(String, DebugDumpable)]()
        fields.append(("children", DebugDumpValue.array(children.map { $0 as DebugDumpable })))
        return .object(name, fields)
    }
    
    internal func decode(json: [String: SourceKitRepresentable]) throws {
        fatalError("abstract")
    }
    
    internal func decodeChildren(json: [String: SourceKitRepresentable]) throws {
        if let subs = json["key.substructure"] as? Array<SourceKitRepresentable> {
            for sub in subs {
                if let sub = sub as? Dictionary<String, SourceKitRepresentable> {
                    if let child = try ASTNode.decode(json: sub) {
                        addChild(child)
                    }
                }
            }
        }
    }
    
    private var _children: [ASTNode] = []
    
    public class var sourceKitKind: String {
        fatalError("abstract")
    }
    
    public static func decode(json: [String: SourceKitRepresentable]) throws -> ASTNode? {
        let kind = try nonNil(json["key.kind"] as? String, "kind key")
        
        for nodeClass in nodeClasses {
            if kind == nodeClass.sourceKitKind {
                let node = nodeClass.init()
                try node.decode(json: json)
                return node
            }
        }

        print("unsupported kind: \(kind)")
        return nil
    }
    
    private static let nodeClasses: [ASTNode.Type] = [
        ClassNode.self
    ]
}
