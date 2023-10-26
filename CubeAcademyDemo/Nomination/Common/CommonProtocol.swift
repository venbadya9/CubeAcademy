import Foundation

// MARK: CallbackStatus Protocol

protocol CallbackStatus {
    func handleSuccess(_ type: APIType)
    func handleFailure(_ message: String)
}

class GlobalManager {
    static let sharedInstance = GlobalManager()
    
    var salutation: [String] = []
    var nomineeDetails: [NomineeData] = []

    private init() {}
}
