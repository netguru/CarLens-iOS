//
//  NSObjectExtension.swift
//  CarLens
//


internal extension NSObject {
    
    /// Name of the class
    class var className: String {
        let namespaceClassName = NSStringFromClass(self)
        return namespaceClassName.components(separatedBy: ".").last!
    }
}
