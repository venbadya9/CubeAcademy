import UIKit
import SwiftUI

class CreateNominationVC: UIViewController {
   
    // MARK: Constants
    
    let navigationTitle = "Create a nomination"
    let cubeHeaderString = "* Cube's name"
    let reasonigHeaderString = "* Reasoning"
    let satisfactionHeaderStrig = "IS HOW WE CURRENTLY RUN CUBE OF THE MONTH FAIR?"
    private let notificationCenter = NotificationCenter.default
    
    
    // MARK: IBOutlets
    
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cubeHeaderLabel: UILabel!
    @IBOutlet weak var cubeNameTextField: UITextField!
    @IBOutlet weak var reasoningHeaderLabel: UILabel!
    @IBOutlet weak var reasoningTextView: UITextView!
    @IBOutlet weak var satisfactionHeaderLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var submitNominationButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var decisionView: UIView!
    @IBOutlet weak var cancellationView: UIView!
    @IBOutlet weak var leavePageButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet var satisfactionView: [UIView]!
    @IBOutlet var satisfactionButton: [UIButton]! {
        didSet{
            satisfactionButton.forEach { button in
                button.setImage(UIImage(named: "Inactive"), for: .normal)
                button.setImage(UIImage(named: "Active"), for: .selected)
            }
        }
    }
    
    // MARK: Variables
    
    var satisfactionIndex: Int = 0
    var selectedUUID: String = ""
    var viewModel: SubmissionDataViewModel?
    var picker: PickerView?
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Adding Observer for completion check
        notificationCenter.addObserver(self, selector:#selector(checkForCompletion(notification:)), name: Notification.Name("CompletionCheck"), object: nil)
    }
    
    // Conforming to Keyboard Notifications.
    override func viewWillAppear(_ animated: Bool) {
        notificationCenter.addObserver(self, selector: #selector(CreateNominationVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(CreateNominationVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Resetting Fields
        resetFields()
    }
    
    // Removing Keyboard Notifications Observer's.
    override func viewWillDisappear(_ animated: Bool) {
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.removeObserver(self, name: Notification.Name("CompletionCheck"), object: nil)
    }
    
    // MARK: Methods
    
    private func setupUI() {
        
        //Setting Navigation Header.
        navigationView.isHome = false
        navigationView.title = navigationTitle
        
        // Adding attributes to string.
        let range = NSRange(location: 0, length: 1)
        cubeHeaderLabel.attributedText = cubeHeaderLabel.getAttributedString(cubeHeaderString, range)
        reasoningHeaderLabel.attributedText = reasoningHeaderLabel.getAttributedString(reasonigHeaderString, range)
        
        let attributedRange = NSRange(location: 24, length: 17)
        satisfactionHeaderLabel.attributedText = satisfactionHeaderLabel.getAttributedString(satisfactionHeaderStrig, attributedRange)
        
        // Adding padding to match UI.
        cubeNameTextField.setLeftPaddingPoints(5)
        cubeNameTextField.setRightPaddingPoints(5)
        
        // Setting border to textfield's and view.
        [cubeNameTextField, reasoningTextView].forEach { textfield in
            textfield.layer.borderColor = UIColor.shadowStrong.cgColor
            textfield.layer.borderWidth = 1.0
        }
        
        [backButton, leavePageButton, cancelButton].forEach { button in
            button.addBorder(UIColor.black)
        }
        
        satisfactionView.forEach { view in
            view.addBorder()
        }
        
        // Adding drop shadow
        bottomView.dropShadow()
        cancellationView.dropShadow()
        
        // Generating viewmodel and setting up callback
        viewModel = generateSubmissionViewModel()
        viewModel?.output = self
        
        self.loadDropdownData(data: GlobalManager.sharedInstance.salutation)
    }
    
    // Removing previously checked radio button.
    private func uncheck() {
        satisfactionButton.forEach { button in
            button.isSelected = false
        }
    }
    
    // Providing input to load data for Picker.
    func loadDropdownData(data: [String]) {
        picker = PickerView(pickerData: data, dropdownField: cubeNameTextField)
        self.cubeNameTextField.inputView = picker
        picker?.pickerDelegate = self
    }
    
    // Configuring the decision view to quit editing nomination screen with animation.
    private func animateDecisionView(_ show: Bool) {
        decisionView.isHidden = show
        decisionView.animateView()
    }
    
    // Resetting all values
    private func resetFields() {
        cubeNameTextField.text = nil
        reasoningTextView.text = nil
        reasoningTextView.resignFirstResponder()
        satisfactionIndex = 0
        uncheck()
        scrollView.scrollToTop()
    }
    
    private func getSatisfaction(index: Int) -> SatisfactionType? {
        switch index {
        case 1: return SatisfactionType.veryUnFair
        case 2: return SatisfactionType.unfair
        case 3: return SatisfactionType.notSure
        case 4: return SatisfactionType.fair
        case 5: return SatisfactionType.veryFair
        default:
            return nil
        }
    }
    
    // Checking for completion of all fields
    @objc func checkForCompletion(notification: NSNotification) {
        if cubeNameTextField.checkForNonEmpty()
            && satisfactionIndex > 0
            && reasoningTextView.validateTextView() {
            
            self.submitNominationButton.isUserInteractionEnabled = true
            self.submitNominationButton.backgroundColor = UIColor.black
        }
    }
    
    // MARK: IBActions
    
    // Enablng selection of radio button to provide feedback.
    @IBAction func satisfactionButtonTapped(_ sender: UIButton) {
        uncheck()
        sender.checkboxAnimation {
            self.satisfactionView.forEach { view in
                if view.tag == sender.tag {
                    view.addBorder(UIColor.cubeDarkGrey)
                    
                    // Setting index for completion check.
                    self.satisfactionIndex = view.tag
                    NotificationCenter.default.post(name: Notification.Name("CompletionCheck"), object: nil)
                } else {
                    view.addBorder()
                }
            }
        }
    }
    
    // Showing decision screen for navigation.
    @IBAction func backButtonTapped(_ sender: UIButton) {
        animateDecisionView(false)
    }
    
    @IBAction func submitNominationTapped(_ sender: UIButton) {
        // Calling API to submit nominations.
        
        let process = getSatisfaction(index: satisfactionIndex)
        let json: [String: Any] = ["nominee_id": selectedUUID, "reason": reasoningTextView.text ?? "", "process": process?.rawValue ?? ""]
        viewModel?.submitNominationtDetails(json: json)
    }
    
    // Navigating back to home screen.
    @IBAction func leavePageTapped(_ sender: UIButton) {
        animateDecisionView(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    // Remaining on current screen for editing and submission.
    @IBAction func cancelTapped(_ sender: UIButton) {
        animateDecisionView(true)
    }
}
