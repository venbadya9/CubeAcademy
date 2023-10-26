import Foundation

class SubmissionUseCase: SubmissionUseCaseModel {
    
    // MARK: Private Variables
    
    private let networkManager: NetworkManagerModel
    
    init(networkManager: NetworkManagerModel) {
        self.networkManager = networkManager
    }

    // MARK: Protocol Functions
    
    func submitNominationDetails(json: [String: Any], completion: @escaping SubmissionResponse) {
        return self.networkManager.request(requestType: HTTPType.post.rawValue, fromUrl: NominationAPIEndpoints.submitNominationEndpoint, json: json, completion: completion)
    }
}
