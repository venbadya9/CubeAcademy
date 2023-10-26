import Foundation

class NominationViewModel: NominationDataViewModel {
    
    // MARK: Variables
    
    var output: CallbackStatus?
    var nominations: [NominationCellViewModel]? = [NominationCellViewModel]()
    var nominationModel: NominationModel?
    var nomineeModel: NomineeModel?
    
    // MARK: Private Variables
    
    private let useCase: NominationUseCaseModel
    
    // MARK: Object Lifecycle
    
    init(useCase: NominationUseCaseModel) {
        self.useCase = useCase
    }
    
    // MARK: Protocol Functions
    
    
    func fetchNomineeDetails() {
        self.useCase.fetchNomineeDetails { [weak self] result in
            switch result {
            case let .success(nomineeList):
                self?.nomineeModel = nomineeList
                self?.output?.handleSuccess(APIType.fetchNominee)
            case let .failure(error):
                self?.output?.handleFailure(error.localizedDescription)
            }
        }
    }
    
    func fetchDetails() {
        self.useCase.fetchNominations { [weak self] result in
            switch result {
            case let .success(nominationList):
                self?.nominationModel = nominationList
                let nominations = nominationList.data
                self?.nominations = self?.processFetchedNominations(nominations) ?? []
                self?.output?.handleSuccess(APIType.fetchNomination)
            case let .failure(error):
                self?.output?.handleFailure(error.localizedDescription)
            }
        }
    }
    
    // MARK: Methods
    
    func processFetchedNominations(_ nominations: [NominationModel.NominationData]) -> [NominationCellViewModel] {
        var nominationCellViewModel = [NominationCellViewModel]()
        for nomination in nominations {
            nominationCellViewModel.append(generateCellViewModel(nomination))
        }
        return nominationCellViewModel
    }
    
    func generateCellViewModel(_ nomination: NominationModel.NominationData) -> NominationCellViewModel {
        return NominationCellViewModel(
            nomination.nominationID,
            nomination.nomineeID,
            nomination.reason,
            nomination.process,
            nomination.dateSubmitted,
            nomination.closingDate
        )
    }
}
