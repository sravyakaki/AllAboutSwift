// 
//  Copyright © 2020 Big Nerd Ranch
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    // declaring property observer for fahrenheit value which is declared in curly braces
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    // Celsius value is a computed property
    var celsiusValue: Measurement<UnitTemperature>? {
    
    if let fahrenheitValue = fahrenheitValue {
        return fahrenheitValue.converted(to: .celsius)
    } else {
        return nil
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        updateCelsiusLabel()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()


    func textField(_ textfield: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textfield.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let characterSet = CharacterSet(charactersIn: string)
        let finalValueEntryString = allowedCharacters.isSuperset(of: characterSet)
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else if finalValueEntryString {
            return true
        } else {
            return false
        }
        
    }
    

}

