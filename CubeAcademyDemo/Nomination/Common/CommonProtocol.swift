import Foundation

// MARK: CallbackStatus Protocol

protocol CallbackStatus {
    func handleSuccess(_ type: APIType)
    func handleFailure(_ message: String)
}

func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}

func parse(jsonData: Data) -> NomineeModel? {
    do {
        let decodedData = try JSONDecoder().decode(NomineeModel.self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}
