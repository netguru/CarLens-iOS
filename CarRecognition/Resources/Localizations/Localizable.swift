//
//  Localizable.swift
//  CarRecognition
//


internal struct Localizable {
    
    struct Common {
        static let loremIpsum = localized("lorem.ipsum")
        static let ok = localized("ok")
        static let cancel = localized("cancel")
        static let confirm = localized("confirm")
        static let next = localized("next")
        static let back = localized("back")
        static let done = localized("done")
        static let close = localized("close")
        static let yes = localized("yes")
        static let no = localized("no")
    }
    
    struct Recognition {
        static let putCarInCenter = localized("recognition.put.car.in.center")
        static let carNotSupported = localized("recognition.car.not.supported")
        static let recognizing = localized("recognition.recognizing")
    }
    
    struct CarCard {
        static let accelerate0to60mph = localized("car.card.accelerate.0.to.60.mph")
        static let topSpeed = localized("car.card.top.speed")
        static let power = localized("car.card.power")
        static let engine = localized("car.card.engine")
        static let mph = localized("car.card.mph")
        static let hp = localized("car.card.hp")
    }
    
    struct CarsList {
        static let title = localized("cars.list.title")
    }
    
    struct CameraAccess {
        static let information = localized("camera-access.information")
        static let accessButton = localized("camera-access.button.text")
    }
    
    struct Error {
        static let title = localized("error.title")
        static let unknownErrorOccurred = localized("error.unknown.error.occurred")
    }
}

private func localized(_ value: String) -> String {
    return NSLocalizedString(value, comment: "")
}
