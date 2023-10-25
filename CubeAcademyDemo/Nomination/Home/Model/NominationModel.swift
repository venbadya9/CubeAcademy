import Foundation

// Nomination Model
struct NominationModel: Decodable {
    let data: [NominationData]
}

extension NominationModel {
    struct NominationData: Decodable {
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
