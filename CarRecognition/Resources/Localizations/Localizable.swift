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
        static let pointCameraAtCar = localized("recognition.point.camera.at.car")
        static let otherCar = localized("recognition.other.car")
        static let recognizing = localized("recognition.recognizing")
    }
    
    struct CarCard {
        static let accelerate0to60mph = localized("car.card.accelerate.0.to.60.mph")
        static let accelerate0to100kph = localized("car.card.accelerate.0.to.100.kph")
        static let topSpeed = localized("car.card.top.speed")
        static let power = localized("car.card.power")
        static let engine = localized("car.card.engine")
        static let mph = localized("car.card.mph")
        static let kph = localized("car.card.kph")
        static let hp = localized("car.card.hp")
        static let cc = localized("car.card.engine.capacity")
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
