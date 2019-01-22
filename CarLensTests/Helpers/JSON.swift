//
//  JSON.swift
//  CarLensTests
//

enum JSON {
    static func readFile(name: String) -> Data? {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: name, withExtension: ".json")
            .flatMap { try? Data(contentsOf: $0) }
    }
}
