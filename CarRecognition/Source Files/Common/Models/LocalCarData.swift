//
//  LocalCarData.swift
//  CarRecognition
//


internal struct LocalCarData: Decodable {
    let id: String
    let brand: String
    let model: String
    let description: String
    let stars: Int
    let acceleration: Double
    let speed: Int
    let power: Int
    let engine: Int
    let brandLogoImageName: String
    let brandLogoImageLockedName: String
    let imageName: String
    let imageLockedName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case brand = "brand"
        case model = "model"
        case description = "description"
        case stars = "stars"
        case acceleration = "acceleration_mph"
        case speed = "speed_mph"
        case power = "power"
        case engine = "engine"
        case brandLogoImageName = "brand_logo_image"
        case brandLogoImageLockedName = "brand_logo_image_locked"
        case imageName = "image"
        case imageLockedName = "image_locked"
    }
}
