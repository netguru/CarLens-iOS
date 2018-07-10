//
//  Car.swift
//  CarRecognition
//

import UIKit.UIImage

internal struct Car: Decodable, Equatable {
    let id: String
    let brand: String
    let model: String
    let description: String
    let stars: Int
    let acceleration: Double
    let speed: Int
    let power: Int
    let engine: Int
    private let brandLogoImageUnlocked: UIImage
    private let brandLogoImageLocked: UIImage
    private let imageUnlocked: UIImage
    private let imageLocked: UIImage
    var discovered: Bool = false
    var image: CarImage {
        return CarImage(unlocked: imageUnlocked, locked: imageLocked, logoUnlocked: brandLogoImageUnlocked, logoLocked: brandLogoImageLocked)
    }
    
    /// SeeAlso: Decodable
    enum CodingKeys: String, CodingKey {
        case id
        case brand
        case model
        case description
        case stars
        case acceleration = "acceleration_mph"
        case speed = "speed_mph"
        case power
        case engine
        case brandLogoImageUnlocked = "brand_logo_image"
        case brandLogoImageLocked = "brand_logo_image_locked"
        case imageUnlocked = "image"
        case imageLocked = "image_locked"
    }
    
    /// SeeAlso: Decodable
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        brand = try values.decode(String.self, forKey: .brand)
        model = try values.decode(String.self, forKey: .model)
        description = try values.decode(String.self, forKey: .description)
        stars = try values.decode(Int.self, forKey: .stars)
        acceleration = try values.decode(Double.self, forKey: .acceleration)
        speed = try values.decode(Int.self, forKey: .speed)
        power = try values.decode(Int.self, forKey: .power)
        engine = try values.decode(Int.self, forKey: .engine)
        
        let brandLogoImageName = try values.decode(String.self, forKey: .brandLogoImageUnlocked)
        brandLogoImageUnlocked = UIImage(named: brandLogoImageName)!
        let brandLogoImageLockedName = try values.decode(String.self, forKey: .brandLogoImageLocked)
        brandLogoImageLocked = UIImage(named: brandLogoImageLockedName)!
        let imageName = try values.decode(String.self, forKey: .imageUnlocked)
        imageUnlocked = UIImage(named: imageName)!
        let imageLockedName = try values.decode(String.self, forKey: .imageLocked)
        imageLocked = UIImage(named: imageLockedName)!
    }
}
