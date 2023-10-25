import Foundation

struct NominationCellViewModel {

    let nominationID: String
    let nomineeID: String
    let reason: String
    let process: String
    let dateSubmitted: String
    let closingDate: String
    
    init(_ nominationID: String, _ nomineeID: String, _ reason: String, _ process: String, _ dateSubmitted: String, _ closingDate: String) {
        self.nominationID = nominationID
        self.nomineeID = nomineeID
        self.reason = reason
        self.process = process
        self.dateSubmitted = dateSubmitted
        self.closingDate = closingDate
    }
}
