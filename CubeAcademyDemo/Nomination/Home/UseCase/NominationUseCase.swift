import Foundation

class NominationUseCase: NominationUseCaseModel {
    
    // MARK: Private Variables
    
    private let networkManager: NetworkManagerModel
    
    init(networkManager: NetworkManagerModel) {
        self.networkManager = networkManager
    }

    // MARK: Protocol Functions
    
    func fetchNominations(completion: @escaping NominationResponse) {
        return self.networkManager.request(requestType: HTTPType.get.rawValue, fromUrl: NominationAPIEndpoints.submitNominationEndpoint, json: [:], completion: completion)
    }
}
