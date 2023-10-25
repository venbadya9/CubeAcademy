import Foundation
import UIKit
import CubeFoundationSwiftUI

extension UIView {

    // Adding drop shadow.
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = FigmaShadow.strong.color.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // Adding border.
    func addBorder(_ color: UIColor = UIColor.cubeMidGrey) {
        layer.borderWidth = 1.0
        layer.borderColor = color.cgColor
    }
    
    // Animating view.
    func animateView() {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: UIView.AnimationOptions.curveLinear, animations: {
            let height = 360
            self.frame = CGRect(x: 0, y: Int(self.frame.origin.y), width: Int(self.frame.size.width), height: height)
        }, completion: nil)
    }
}

extension UITextField {
    
    // Setting padding to start first character position in textfield.
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    // Setting padding to finish last character position in textfield.
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    // Checking for non empty textfield
    func checkForNonEmpty() -> Bool {
        self.text = self.text?.trimmingCharacters(in: .whitespaces)
        guard let string = self.text, !string.isEmpty else { return false }
        return true
    }
}

extension UILabel {
    
    // Adding attributes to string.
    func getAttributedString(_ text: String, _ range: NSRange) -> NSAttributedString {
        let attribute = [NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: 16)]
        let attributedText = NSMutableAttributedString(string: text, attributes: attribute as [NSAttributedString.Key : Any])
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.accent, range: range)
        return attributedText
    }
}

extension UIButton {

    // Adding animation for radio button.
    func checkboxAnimation(closure: @escaping () -> Void) {
        guard let image = self.imageView else {return}
        self.isHighlighted = false
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                closure()
                image.transform = .identity
            }, completion: nil)
        }
    }
}

extension UITextView {
    
    // Validating non-empty textview
    func validateTextView () -> Bool {
        guard let text = self.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }
}

extension UIScrollView {
    
    // Scroll to top
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
   }
}
