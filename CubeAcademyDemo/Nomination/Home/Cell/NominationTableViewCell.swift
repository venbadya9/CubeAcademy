import Foundation
import UIKit

class NominationTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    
    @IBOutlet private weak var nominationName: UILabel!
    @IBOutlet private weak var reason: UILabel!
    
    // MARK: Variables
    
    
    // Using UserCellViewModel for configuring cell
    var nominationCellModel : NominationCellViewModel? {
        didSet {
            if let index = GlobalManager.sharedInstance.nomineeDetails.firstIndex(where: {$0.nomineeID == nominationCellModel?.nomineeID}) {
                nominationName.text = GlobalManager.sharedInstance.nomineeDetails[index].firstName + " " + (GlobalManager.sharedInstance.nomineeDetails[index].lastName)
                reason.text = nominationCellModel?.reason
            }
        }
    }
    
    // MARK: Object Lifecycle
    
    override func awakeFromNib() {}
}
