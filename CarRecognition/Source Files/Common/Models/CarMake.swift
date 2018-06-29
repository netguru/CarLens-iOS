//
//  CarMake.swift
//  CarRecognition
//


/// Supported makes of the car
internal enum CarMake: String, CustomStringConvertible {
    case ford = "ford"
    case hodna = "honda"
    case nissan = "nissan"
    case toyota = "toyota"
    case volkswagen = "volkswagen"
    
    /// SeeAlso: CustomStringConvertible
    var description: String {
        return self.rawValue.capitalized
    }
}
