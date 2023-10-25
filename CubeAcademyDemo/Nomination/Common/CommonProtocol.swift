import Foundation

// MARK: CallbackStatus Protocol

protocol CallbackStatus {
    func handleSuccess(_ type: APIType)
    func handleFailure(_ message: String)
}
