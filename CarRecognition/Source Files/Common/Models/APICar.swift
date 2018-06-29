//
//  APICar.swift
//  CarRecognition
//


internal struct APICar: Decodable {
    
    let id: String?
    let make: String?
    let name: String?
    let trim: String?
    let year: String?
    let body: String?
    let enginePosition: String?
    let engineCC: String?
    let engineCylinder: String?
    let engineType: String?
    let engineValvesPerCylinder: String?
    let enginePowerPS: String?
    let enginePowerRPM: String?
    let engineTorqueNm: String?
    let engineTorqueRPM: String?
    let engineBoreMm: String?
    let engineStrokeMm: String?
    let engineCompression: String?
    let engineFuel: String?
    let topSpeedKph: String?
    let accelerate0to100kph: String?
    let drive: String?
    let transmissionType: String?
    let seats: String?
    let doors: String?
    let weightKg: String?
    let lengthMm: String?
    let widthMm: String?
    let heightMm: String?
    let wheelbaseMm: String?
    let lkmHeavy: String?
    let lkmMixed: String?
    let lkmCity: String?
    let fuelCap: String?
    let soldInUS: String?
    let co2: String?
    let makeCountry: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "model_id"
        case make = "make_display"
        case name = "model_name"
        case trim = "model_trim"
        case year = "model_year"
        case body = "model_body"
        case enginePosition = "model_engine_position"
        case engineCC = "model_engine_cc"
        case engineCylinder = "model_engine_cyl"
        case engineType = "model_engine_type"
        case engineValvesPerCylinder = "model_engine_valves_per_cyl"
        case enginePowerPS = "model_engine_power_ps"
        case enginePowerRPM = "model_engine_power_rpm"
        case engineTorqueNm = "model_engine_torque_nm"
        case engineTorqueRPM = "model_engine_torque_rpm"
        case engineBoreMm = "model_engine_bore_mm"
        case engineStrokeMm = "model_engine_stroke_mm"
        case engineCompression = "model_engine_compression"
        case engineFuel = "model_engine_fuel"
        case topSpeedKph = "model_top_speed_kph"
        case accelerate0to100kph = "model_0_to_100_kph"
        case drive = "model_drive"
        case transmissionType = "model_transmission_type"
        case seats = "model_seats"
        case doors = "model_doors"
        case weightKg = "model_weight_kg"
        case lengthMm = "model_length_mm"
        case widthMm = "model_width_mm"
        case heightMm = "model_height_mm"
        case wheelbaseMm = "model_wheelbase_mm"
        case lkmHeavy = "model_lkm_hwy"
        case lkmMixed = "model_lkm_mixed"
        case lkmCity = "model_lkm_city"
        case fuelCap = "model_fuel_cap_l"
        case soldInUS = "model_sold_in_us"
        case co2 = "model_co2"
        case makeCountry = "make_country"
    }
    
    var arrayDescription: [(description: String, value: String?)] {
        return [
            (description: CodingKeys.id.rawValue, value: id),
            (description: CodingKeys.make.rawValue, value: make),
            (description: CodingKeys.name.rawValue, value: name),
            (description: CodingKeys.trim.rawValue, value: trim),
            (description: CodingKeys.year.rawValue, value: year),
            (description: CodingKeys.body.rawValue, value: body),
            (description: CodingKeys.enginePosition.rawValue, value: enginePosition),
            (description: CodingKeys.engineCC.rawValue, value: engineCC),
            (description: CodingKeys.engineCylinder.rawValue, value: engineCylinder),
            (description: CodingKeys.engineType.rawValue, value: engineType),
            (description: CodingKeys.engineValvesPerCylinder.rawValue, value: engineValvesPerCylinder),
            (description: CodingKeys.enginePowerPS.rawValue, value: enginePowerPS),
            (description: CodingKeys.enginePowerRPM.rawValue, value: enginePowerRPM),
            (description: CodingKeys.engineTorqueNm.rawValue, value: engineTorqueNm),
            (description: CodingKeys.engineTorqueRPM.rawValue, value: engineTorqueRPM),
            (description: CodingKeys.engineBoreMm.rawValue, value: engineBoreMm),
            (description: CodingKeys.engineStrokeMm.rawValue, value: engineStrokeMm),
            (description: CodingKeys.engineCompression.rawValue, value: engineCompression),
            (description: CodingKeys.engineFuel.rawValue, value: engineFuel),
            (description: CodingKeys.topSpeedKph.rawValue, value: topSpeedKph),
            (description: CodingKeys.accelerate0to100kph.rawValue, value: accelerate0to100kph),
            (description: CodingKeys.drive.rawValue, value: drive),
            (description: CodingKeys.transmissionType.rawValue, value: transmissionType),
            (description: CodingKeys.seats.rawValue, value: seats),
            (description: CodingKeys.doors.rawValue, value: doors),
            (description: CodingKeys.weightKg.rawValue, value: weightKg),
            (description: CodingKeys.lengthMm.rawValue, value: lengthMm),
            (description: CodingKeys.widthMm.rawValue, value: widthMm),
            (description: CodingKeys.heightMm.rawValue, value: heightMm),
            (description: CodingKeys.wheelbaseMm.rawValue, value: wheelbaseMm),
            (description: CodingKeys.lkmHeavy.rawValue, value: lkmHeavy),
            (description: CodingKeys.lkmMixed.rawValue, value: lkmMixed),
            (description: CodingKeys.lkmCity.rawValue, value: lkmCity),
            (description: CodingKeys.fuelCap.rawValue, value: fuelCap),
            (description: CodingKeys.soldInUS.rawValue, value: soldInUS),
            (description: CodingKeys.co2.rawValue, value: co2),
            (description: CodingKeys.makeCountry.rawValue, value: makeCountry)
        ]
    }
}

extension APICar: CustomStringConvertible {
    var description: String {
        return "\(make ?? "") \(name ?? ""), \(year ?? ""), \(engineCC ?? "")cc, \(enginePowerPS ?? "") HP"
    }
}
