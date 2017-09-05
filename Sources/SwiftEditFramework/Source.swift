import Foundation
import SourceKittenFramework

public class Source : ASTNode, CustomStringConvertible {
    public required init() {}
    
    public init(path: String) throws {
        text = try String.init(contentsOfFile: path)
        super.init()
        
        let resp = Request.editorOpen(file: File(contents: text)).send()
        try parse(response: resp)
    }

    public var description: String {
        return "Source"
    }
    
    private func parse(response: [String: SourceKitRepresentable]) throws {
        try decodeChildren(json: response)
    }
    
    private var text: String = ""
}
