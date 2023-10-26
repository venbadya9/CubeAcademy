import Foundation

protocol SubmissionUseCaseModel {
    func submitNominationDetails(json: [String: Any], completion: @escaping SubmissionResponse)
}
