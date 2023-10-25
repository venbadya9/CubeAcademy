import UIKit
import Foundation

final class NavigationView: UIView {
    
    // MARK: Constants
    
    private static let NIB_NAME = "NavigationView"
    
    // MARK: IBOutlets
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    // MARK: Variables
    
    // Setting up title of navigation header.
    var title: String = "" {
        didSet {
            headerLabel.text = title
        }
    }
    
    // To display logo based on the boolean value passed.
    var isHome: Bool {
        set {
            headerLabel.isHidden = newValue
            isNomination = newValue
        }
        get { return headerLabel.isHidden }
    }
    
    // To hide/unhide the title label based on the boolean value passed.
    var isNomination: Bool {
        set { logo.isHidden = !newValue }
        get { return logo.isHidden }
    }
    
    // MARK: Initialisations
    
    override func awakeFromNib() {
        initWithNib()
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed(NavigationView.NIB_NAME, owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setupLayout()
    }
    
    // MARK: Private Functions
    
    // Setting up the constraints.
    private func setupLayout() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
