//
//  ApplicationKeys.swift
//  CarLens
//


/// Common interface for securely providing keys
struct ApplicationKeys {

    /// The cocoapods-keys instance
    let keys: CarLensKeys

    /// The Hockey App app identifier
    var hockeyAppIdentifier: String {
        #if ENV_PRODUCTION
            return keys.hOCKEYAPP_APP_ID_PRODUCTION
        #elseif ENV_STAGING || ENV_DEVELOPMENT
            return keys.hOCKEYAPP_APP_ID_STAGING
        #endif
    }
}
