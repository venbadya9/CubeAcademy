import Foundation

// MARK: SubmissionViewModel Protocol

protocol SubmissionDataViewModel {
    var output: CallbackStatus? { get set }
    var nomineeModel: NomineeModel? { get set }
    func fetchNomineeDetails()
    func submitNominationtDetails(json: [String: Any])
}

extension SubmissionDataViewModel {
    
    var nomineeModel: NomineeModel? {
        get { return nil } set {}
    }
}
