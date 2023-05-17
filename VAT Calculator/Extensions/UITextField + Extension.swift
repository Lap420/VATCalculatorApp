import UIKit

extension UITextField {
    convenience init(returnKey: UIReturnKeyType) {
        self.init()
        placeholder = UIConstants.placeholder
        font = UIConstants.fontRegular
        textAlignment = .right
        borderStyle = .roundedRect
        clearButtonMode = .whileEditing
        keyboardType = .decimalPad
        returnKeyType = returnKey
        clearsOnBeginEditing = true
    }
}
