
import Darwin
import Dispatch
import SwiftEditFramework

func main() throws {
    if CommandLine.arguments.count < 2 {
        fatalError("no file specified")
    }
    
    let file = CommandLine.arguments[1]
    
    let source = try Source(path: file)
    print(source.debugDescription)
    
    exit(EXIT_SUCCESS)
}

DispatchQueue.main.async {
    try! main()
}

dispatchMain()
