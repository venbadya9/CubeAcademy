import Foundation

// MARK: SubmissionViewModel Protocol

protocol SubmissionDataViewModel {
    var output: CallbackStatus? { get set }
    func submitNominationtDetails(json: [String: Any])
}
