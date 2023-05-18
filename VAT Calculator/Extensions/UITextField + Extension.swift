import UIKit

extension UITextField {
    func setupTF() {
        placeholder = UIConstants.placeholder
        font = UIConstants.fontRegular
        textAlignment = .right
        borderStyle = .roundedRect
        clearButtonMode = .whileEditing
        keyboardType = .decimalPad
        clearsOnBeginEditing = true
    }
}
