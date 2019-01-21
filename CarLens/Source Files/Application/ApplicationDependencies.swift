//
//  ApplicationDependencies.swift
//  CarLens
//


/// Shared dependencies used extensively in the application
internal class ApplicationDependencies {
    
    lazy var applicationKeys: ApplicationKeys = ApplicationKeys(keys: CarLensKeys())
    
    lazy var crashLogger: CrashLogger = HockeyAppService(keys: applicationKeys)
    
    lazy var carsDataService = CarsDataService()
}
