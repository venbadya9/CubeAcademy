import Foundation

// Submission Model
struct SubmissionModel: Decodable {
    let data: SubmissionData
}

extension SubmissionModel {
    struct SubmissionData: Decodable {
        let nominationID, nomineeID, reason, process: String
        let dateSubmitted, closingDate: String
        
        private enum CodingKeys: String, CodingKey {
            case nominationID = "nomination_id"
            case nomineeID = "nominee_id"
            case reason, process
            case dateSubmitted = "date_submitted"
            case closingDate = "closing_date"
        }
    }
}

// Nominee Model
struct NomineeModel: Decodable {
    let data: [NomineeData]
}

extension NomineeModel {
    struct NomineeData: Decodable {
        let nomineeID, firstName, lastName: String
        
        private enum CodingKeys: String, CodingKey {
            case nomineeID = "nominee_id"
            case firstName = "first_name"
            case lastName = "last_name"
        }
    }
}
