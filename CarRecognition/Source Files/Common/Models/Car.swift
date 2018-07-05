//
//  Car.swift
//  CarRecognition
//

import UIKit

/// Describes supported cars
internal enum Car: Equatable, CustomStringConvertible {
    
    case known(make: CarMake, model: String)
    case other
    
    /// Initializes the enum with proper type if possiblle
    ///
    /// - Parameter label: Label used for initialization
    init?(label: String) {
        switch label {
        case "other car":
            self = .other
        case "not car":
            return nil
        default:
            let splittedWords = label.split(separator: " ")
            guard
                splittedWords.count >= 2,
                let makeWord = splittedWords.first,
                let modelWord = splittedWords.last,
                makeWord != modelWord,
                let make = CarMake(rawValue: String(makeWord))
            else {
                return nil
            }
            self = .known(make: make, model: String(modelWord))
        }
    }
    
    /// SeeAlso: CustomStringConvertible
    var description: String {
        switch self {
        case .known(let make, let model):
            return "\(make.description) \(model.description.capitalized)"
        case .other:
            return Localizable.Recognition.carNotSupported
        }
    }

    var brand: String {
        switch self {
        case .known(let make, _):
            return make.description
        case .other:
            return Localizable.Recognition.carNotSupported
        }
    }

    var model: String {
        switch self {
        case .known(_, let model):
            return model
        case .other:
            return Localizable.Recognition.carNotSupported
        }
    }
    
    var image: UIImage {
        switch self {
        case .known(let make, let model):
            switch make {
            case .ford:
                return #imageLiteral(resourceName: "FordFiesta")
            case .hodna:
                return #imageLiteral(resourceName: "HondaCivic")
            case .nissan:
                return #imageLiteral(resourceName: "NissanQashqai")
            case .toyota:
                return model == "Camry" ? #imageLiteral(resourceName: "ToyotaCamry") : #imageLiteral(resourceName: "ToyotaCorolla")
            case .volkswagen:
                switch model {
                case "Golf": return #imageLiteral(resourceName: "VolkswagenGolf")
                case "Passat": return #imageLiteral(resourceName: "VolkswagenPassat")
                case "Tiguan": return #imageLiteral(resourceName: "VolkswagenTiguan")
                default: return #imageLiteral(resourceName: "VolkswagenPassat_locked")
                }
            }
        case .other:
            return #imageLiteral(resourceName: "VolkswagenPassat_locked")
        }
    }
}
