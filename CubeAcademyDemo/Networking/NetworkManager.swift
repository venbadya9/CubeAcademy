import Foundation
import UIKit

typealias Response<T: Decodable> = (Result<T, Error>) -> Void
typealias SubmissionResponse = (Result<SubmissionModel, Error>) -> Void
typealias NomineeResponse = (Result<NomineeModel, Error>) -> Void
typealias NominationResponse = (Result<NominationModel, Error>) -> Void

protocol NetworkManagerModel {
    func request<T: Decodable>(requestType: String, fromUrl url: URL, json: [String: Any], completion: @escaping Response<T>)
}

class NetworkManager: NetworkManagerModel {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(requestType: String, fromUrl url: URL, json: [String: Any], completion: @escaping Response<T>) {
        
        let completionOnMain: Response<T> = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
           let authToken = appDelegate.authToken {
            var request = URLRequest(url: url)
            if requestType == "POST" {
                let jsonData = try? JSONSerialization.data(withJSONObject: json)
                request.httpBody = jsonData
            }
            request.httpMethod = requestType
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
            
            let task = session.dataTask(with: request) { data, response, error in
                if let _ = error {
                    completionOnMain(.failure(NetworkError.badRequest))
                }
                
                guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(NetworkError.noResponse)) }
                if !(200...300).contains(urlResponse.statusCode) { return completionOnMain(.failure(NetworkError.failed)) }
                guard let data = data else {
                    return completionOnMain(.failure(NetworkError.noData))
                }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completionOnMain(.success(decodedData))
                } catch {
                    completionOnMain(.failure(NetworkError.unableToDecode))
                }
            }
            task.resume()
        }
    }
}
