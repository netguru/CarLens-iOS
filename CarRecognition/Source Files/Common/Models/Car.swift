//
//  Car.swift
//  CarRecognition
//

import UIKit.UIImage

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

    /// Make of concrete car model
    var make: String {
        switch self {
        case .known(let make, _):
            return make.description
        case .other:
            return Localizable.Recognition.carNotSupported
        }
    }

    /// Model name
    var model: String {
        switch self {
        case .known(_, let model):
            return model.capitalized
        case .other:
            return Localizable.Recognition.carNotSupported
        }
    }
    
    /// Image that represents concrete car model
    var image: CarImage {
        switch self {
        case .known(let make, let model):
            switch make {
            case .ford:
                return CarImage(unlocked: #imageLiteral(resourceName: "FordFiesta"), locked: #imageLiteral(resourceName: "FordFiesta_locked"))
            case .honda:
                return CarImage(unlocked: #imageLiteral(resourceName: "HondaCivic"), locked: #imageLiteral(resourceName: "HondaCivic_locked"))
            case .nissan:
                return CarImage(unlocked: #imageLiteral(resourceName: "NissanQashqai"), locked: #imageLiteral(resourceName: "NissanQashqai_locked"))
            case .toyota:
                return model == "camry" ? CarImage(unlocked: #imageLiteral(resourceName: "ToyotaCamry"), locked: #imageLiteral(resourceName: "ToyotaCamry")) : CarImage(unlocked: #imageLiteral(resourceName: "ToyotaCorolla"), locked: #imageLiteral(resourceName: "ToyotaCorolla_locked"))
            case .volkswagen:
                switch model {
                case "golf": return CarImage(unlocked: #imageLiteral(resourceName: "VolkswagenGolf"), locked: #imageLiteral(resourceName: "VolkswagenGolf_locked"))
                case "passat": return CarImage(unlocked: #imageLiteral(resourceName: "VolkswagenPassat"), locked: #imageLiteral(resourceName: "VolkswagenPassat_locked"))
                case "tiguan": return CarImage(unlocked: #imageLiteral(resourceName: "VolkswagenTiguan"), locked: #imageLiteral(resourceName: "VolkswagenTiguan"))
                default: return CarImage(unlocked: #imageLiteral(resourceName: "VolkswagenPassat_locked"), locked: #imageLiteral(resourceName: "VolkswagenPassat_locked"))
                }
            }
        case .other:
            return CarImage(unlocked: #imageLiteral(resourceName: "VolkswagenPassat_locked"), locked: #imageLiteral(resourceName: "VolkswagenPassat_locked"))
        }
    }
}
