import Foundation

class SubmissionViewModel: SubmissionDataViewModel {
    
    // MARK: Variables
    
    var output: CallbackStatus?
    private let useCase: SubmissionUseCaseModel
    var nomineeModel: NomineeModel?
        
    // MARK: Object Lifecycle
    
    init(useCase: SubmissionUseCaseModel) {
        self.useCase = useCase
    }
    
    // MARK: Protocol Functions
    
    func fetchNomineeDetails() {
        self.useCase.fetchNomineeDetails { [weak self] result in
            switch result {
            case let .success(nomineeList):
                self?.nomineeModel = nomineeList
                self?.output?.handleSuccess(APIType.fetch)
            case let .failure(error):
                self?.output?.handleFailure(error.localizedDescription)
            }
        }
    }
    
    func submitNominationtDetails(json: [String: Any]) {
        self.useCase.submitNominationDetails(json: json, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.output?.handleSuccess(APIType.submit)
            case let .failure(error):
                self?.output?.handleFailure(error.localizedDescription)
            }
        })
    }
}
