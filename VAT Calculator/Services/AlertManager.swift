import UIKit

struct AlertManager {
    static func valueTooHighAlert(textFieldName: String, textField: UITextField) -> UIAlertController {
        let alert = UIAlertController(title: "Value too high",
                                      message: "The number you entered in \"\(textFieldName)\" field is too large",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) { _ in
            textField.text = nil
        }
        alert.addAction(clearAction)
        alert.addAction(okAction)
        return alert
    }
    
    static func incorrectValueAlert(textFieldName: String, textField: UITextField) -> UIAlertController {
        let alert = UIAlertController(title: "Incorrect value",
                                      message: "The value you entered in \"\(textFieldName)\" field is not a number",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) { _ in
            textField.text = nil
        }
        alert.addAction(clearAction)
        alert.addAction(okAction)
        return alert
    }
}
