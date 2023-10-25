import Foundation

protocol NominationUseCaseModel {
    func fetchNominations(completion: @escaping NominationResponse)
}
