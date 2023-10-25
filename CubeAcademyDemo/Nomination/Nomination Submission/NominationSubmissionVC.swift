import UIKit

class NominationSubmissionVC: UIViewController {

    // MARK: Constants
    
    let navigationTitle = "Nomination Submitted"
    
    // MARK: IBOutlets
    
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var homeButton: UIButton!
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Methods
    
    private func setupUI() {
        
        //Setting Navigation Header.
        navigationView.isHome = false
        navigationView.title = navigationTitle
        
        // Adding drop shadow and border
        bottomView.dropShadow()
        homeButton.addBorder(UIColor.black)
    }
    
    // MARK: IBActions
    
    // Navigating back to create nomination screen.
    @IBAction func createButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Navigating back to home screen.
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
