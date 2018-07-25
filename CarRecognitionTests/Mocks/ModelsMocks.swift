//
//  ModelsFactory.swift
//  CarRecognitionTests
//


@testable import CarRecognition

extension Car {
    static func make() -> Car? {
        guard let data = JSON.readFile(name: "MockedCar") else { return nil }
        return try? JSONDecoder().decode(Car.self, from: data)
    }
}
