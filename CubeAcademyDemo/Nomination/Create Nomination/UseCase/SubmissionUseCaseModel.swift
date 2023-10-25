import Foundation

protocol SubmissionUseCaseModel {
    func submitNominationDetails(json: [String: Any], completion: @escaping SubmissionResponse)
    func fetchNomineeDetails(completion: @escaping NomineeResponse)
}
