import Foundation
import UIKit

// UITextFieldDelegate methods for diabling user input (Selection to be done using Picker).
extension CreateNominationVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

// UITextViewDelegate methods for checking character length and done tapped on keyboard.
extension CreateNominationVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Checking for done tapped.
        let resultRange = text.rangeOfCharacter(from: CharacterSet.newlines, options: .backwards)
        if text.count == 1 && resultRange != nil {
            textView.resignFirstResponder()
            return false
        }
        // Characer length check.
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 280
    }
}

// Keyboard Notification Selector Methods.
extension CreateNominationVC {
    
    // Managing the view when keyboard shows up.
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.scrollView.contentOffset.y = keyboardSize.height
            }
        }
    }

    // Arranging the view when keyboard is hidden.
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            
            // Adding Observer for completion check
            NotificationCenter.default.post(name: Notification.Name("CompletionCheck"), object: nil)
        }
    }
}

extension CreateNominationVC: CallbackStatus {
    
    // Success Handling
    func handleSuccess(_ type: APIType) {
        
        if type == APIType.fetch {
            // Configuring textfield to select values from Picker.
            var salutations = [String]()
            viewModel?.nomineeModel?.data.forEach({ details in
                let name = details.firstName + " " + details.lastName
                salutations.append(name)
            })
            self.loadDropdownData(data: salutations)
        } else {
            // Navigating to Nomination Submitted Screen.
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let nominationSubmissionVC = storyboard.instantiateViewController(withIdentifier: "NominationSubmissionVC") as? NominationSubmissionVC else {
                    fatalError()
                }
                self.navigationController?.pushViewController(nominationSubmissionVC, animated: false)
            }
        }
    }
    
    // Failure Handling
    func handleFailure(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: NSLocalizedString("alert", comment: ""), message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// Adding dependency for View Controller
extension CreateNominationVC {
    
    func generateSubmissionViewModel() -> SubmissionDataViewModel {
        let viewModel = SubmissionViewModel(useCase: generateSubmissionUseCase())
        viewModel.fetchNomineeDetails()
        return viewModel
    }
    
    func generateSubmissionUseCase() -> SubmissionUseCaseModel {
        let networkManager = NetworkManager()
        let useCase = SubmissionUseCase(networkManager:networkManager)
        return useCase
    }
}

// Picker Protocol Implementation
extension CreateNominationVC: PickerDelegate {
    func selectedIndex(index: Int) {
        selectedUUID =  viewModel?.nomineeModel?.data[index].nomineeID ?? ""
    }
}

