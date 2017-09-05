//
//  ClassNode.swift
//  SwiftEditFramework
//
//  Created by omochimetaru on 2017/09/05.
//

import Foundation
import SourceKittenFramework

public class ClassNode : ASTNode {
    
    internal override func decode(json: [String: SourceKitRepresentable]) throws {
        print(json)
    }
    
    public class override var sourceKitKind: String {
        return "source.lang.swift.decl.class"
    }
}
