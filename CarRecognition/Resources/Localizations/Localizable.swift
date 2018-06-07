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
    
    struct Error {
        static let title = localized("error.title")
        static let unknownErrorOccurred = localized("error.unknown.error.occurred")
    }
}

private func localized(_ value: String) -> String {
    return NSLocalizedString(value, comment: "")
}
