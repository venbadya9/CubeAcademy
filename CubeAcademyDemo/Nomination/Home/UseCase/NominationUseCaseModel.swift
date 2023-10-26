import Foundation

protocol NominationUseCaseModel {
    func fetchNominations(completion: @escaping NominationResponse)
    func fetchNomineeDetails(completion: @escaping NomineeResponse)
}
