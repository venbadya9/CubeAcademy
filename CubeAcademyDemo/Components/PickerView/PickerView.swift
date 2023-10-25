import Foundation
import UIKit

protocol PickerDelegate {
    func selectedIndex(index: Int)
}
 
class PickerView : UIPickerView {
    
    // MARK: Variables
    
    var pickerData: [String]!
    var pickerTextField: UITextField!
    var pickerDelegate: PickerDelegate?
    
    // MARK: Initialisations
    
    // Configuring picker with inputs.
    init(pickerData: [String], dropdownField: UITextField) {
        super.init(frame: CGRectZero)
        
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
        
        self.delegate = self
        self.dataSource = self
        
        DispatchQueue.main.async {
            self.pickerTextField.text = nil
            if pickerData.count > 0 {
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.isEnabled = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
// MARK: Delegates and Datasources

extension PickerView: UIPickerViewDataSource, UIPickerViewDelegate {
 
    // Sets number of columns in picker view.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
 
    // Sets the number of rows in the picker view.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
 
    // This function sets the text of the picker view to the content of the picker array.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
 
    // When user selects an option, this function will set the text of the text field to reflect the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
        self.pickerDelegate?.selectedIndex(index: row)
        self.pickerTextField.resignFirstResponder()
        
        // Adding Observer for completion check
        NotificationCenter.default.post(name: Notification.Name("CompletionCheck"), object: nil)
    }
}

