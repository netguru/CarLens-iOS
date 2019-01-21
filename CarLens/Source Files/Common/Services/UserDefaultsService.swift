//
//  UserDefaultsService.swift
//  CarLens
//


import Foundation

/// UserDefaults Service used for storing data.
internal final class UserDefaultsService {
    
    private struct Keys {
        static let didShowOnboardingKey = "didShowOnboardingKey"
    }
    
    /// UserDefaultsService shared instance.
    static let shared = UserDefaultsService()
    
    /// UserDefaults used for storing data.
    private var userDefaults: UserDefaults
    
    /// Initializing the service.
    /// - Parameter userDefaults: userDefaults used for storing data.
    private init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    /// Indicating whether the onboarding should be shown.
    var shouldShowOnboarding: Bool {
        return !userDefaults.bool(forKey: Keys.didShowOnboardingKey)
    }
    
    /// Storing the info about shown onboarding.
    func store(didShowOnboarding: Bool) {
        userDefaults.set(didShowOnboarding, forKey: Keys.didShowOnboardingKey)
    }
}
