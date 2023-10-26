import Foundation

// MARK: UserViewModel Protocol

protocol NominationDataViewModel {
    var nominations: [NominationCellViewModel]? { get set }
    var output: CallbackStatus? { get set }
    var nominationModel: NominationModel? { get set }
    var nomineeModel: NomineeModel? { get set }
    func fetchNomineeDetails()
    func fetchDetails()
}

extension NominationDataViewModel {
    
    var nominations: [NominationCellViewModel]? {
        get { return nil } set {}
    }
    
    var nominationModel: NominationModel? {
        get { return nil } set {}
    }
    
    var nomineeModel: NomineeModel? {
        get { return nil } set {}
    }
}
