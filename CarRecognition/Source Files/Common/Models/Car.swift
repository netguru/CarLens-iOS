//
//  Car.swift
//  CarRecognition
//


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
            return "Not supported car"
        }
    }
}
