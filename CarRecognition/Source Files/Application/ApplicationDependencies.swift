//
//  ApplicationDependencies.swift
//  CarRecognition
//


/// Shared dependencies used extensively in the application
internal class ApplicationDependencies {
    
    lazy var applicationFactory = ApplicationFactory(applicationDependencies: self)
    
    lazy var applicationKeys: ApplicationKeys = ApplicationKeys(keys: CarRecognitionKeys())
    
    lazy var crashLogger: CrashLogger = HockeyAppService(keys: applicationKeys)
}
