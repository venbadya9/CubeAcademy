import UIKit

class HomeVC: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var noNominationView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    
    var viewModel: NominationDataViewModel?
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up navigation header and adding drop shadow.
        navigationView.isHome = true
        bottomView.dropShadow()
        viewModel = generateNominationViewModel()
        viewModel?.output = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchDetails()
    }
    
    // MARK: IBActions
    
    // Navigating to nomination screen.
    @IBAction func createNominationTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let createNominationVC = storyboard.instantiateViewController(withIdentifier: "CreateNominationVC") as? CreateNominationVC else {
            fatalError()
        }
        self.navigationController?.pushViewController(createNominationVC, animated: false)
    }
}
