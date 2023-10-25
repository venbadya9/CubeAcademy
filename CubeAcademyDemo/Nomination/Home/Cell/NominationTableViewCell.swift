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
            nominationName.text = nominationCellModel?.nominationID
            reason.text = nominationCellModel?.reason
        }
    }
    
    // MARK: Object Lifecycle
    
    override func awakeFromNib() {}
}
