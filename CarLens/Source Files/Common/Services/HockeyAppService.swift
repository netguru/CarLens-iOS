//
//  HockeyAppService.swift
//  CarLens
//


import HockeySDK

class HockeyAppService: CrashLogger {

    private lazy var hockeyManager: BITHockeyManager? = { [unowned self] in
        #if ENV_DEVELOPMENT
            return nil
        #else
            BITHockeyManager.shared().configure(withIdentifier: self.keys.hockeyAppIdentifier)
            BITHockeyManager.shared().crashManager.crashManagerStatus = .autoSend
            return BITHockeyManager.shared()
        #endif
        }()

    private let keys: ApplicationKeys

    /// Initialize an instance of the receiver
    ///
    /// - Parameter keys: Keys that securely provides credentials
    init(keys: ApplicationKeys) {
        self.keys = keys
    }

    /// - SeeAlso: CrashLogger.start()
    func start() {
        hockeyManager?.start()
    }
}
