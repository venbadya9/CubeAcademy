import Foundation
import UIKit

class NominationTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    
    @IBOutlet private weak var nominationName: UILabel!
    @IBOutlet private weak var reason: UILabel!
    
    // MARK: Variables
    
    var details: NomineeModel?
    
    // Using UserCellViewModel for configuring cell
    var nominationCellModel : NominationCellViewModel? {
        didSet {
            if let index = details?.data.firstIndex(where: {$0.nomineeID == nominationCellModel?.nomineeID}) {
                nominationName.text = details?.data[index].firstName ?? "" + " " + (details?.data[index].lastName ?? "")
                reason.text = nominationCellModel?.reason
            }
        }
    }
    
    // MARK: Object Lifecycle
    
    override func awakeFromNib() {
        getNomineeDetails()
    }
    
    //MARK: Methods
    
    func getNomineeDetails() {
        let jsonData = readLocalJSONFile(forName: "Nominee")
        if let data = jsonData {
            if let nomineeDetails = parse(jsonData: data) {
                details = nomineeDetails
            }
        }
    }
}
