//
//  NSObjectExtension.swift
//  CarRecognition
//


internal extension NSObject {
    
    /// Name of the class
    class var className: String {
        let namespaceClassName = NSStringFromClass(self)
        return namespaceClassName.components(separatedBy: ".").last!
    }
    
    /// Name of the class
    var className: String {
        let namespaceClassName = NSStringFromClass(self.classForCoder)
        return namespaceClassName.components(separatedBy: ".").last!
    }
}
