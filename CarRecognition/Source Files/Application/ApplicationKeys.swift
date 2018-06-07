//
//  ApplicationKeys.swift
//  CarRecognition
//


/// Common interface for securely providing keys
internal struct ApplicationKeys {
    
    /// The cocoapods-keys instance
    let keys: CarRecognitionKeys
    
    /// The Hockey App app identifier
    internal var hockeyAppIdentifier: String {
        #if ENV_PRODUCTION
            return ""
        #elseif ENV_STAGING || ENV_DEVELOPMENT
            return keys.hOCKEYAPP_APP_ID_STAGING
        #endif
    }
}
