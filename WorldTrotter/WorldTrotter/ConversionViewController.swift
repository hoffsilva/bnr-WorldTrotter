//
// Created by Cast Group on 13/11/2018.
// Copyright (c) 2018 hoffsilva. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()

    var isFarenheitToCelsius = true
    
    @IBOutlet weak var textFieldTemperature: UITextField!
    @IBOutlet weak var labelDescriptionNonConvertedTemperature: UILabel!
    @IBOutlet weak var labelConvertedTemperature: UILabel!
    @IBOutlet weak var labelDescriptionConvertedTemperature: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldTemperature.delegate = self
        setLabelNames()
        print("Conversion view controller loaded its view.")
    }

    private func setLabelNames() {
        if isFarenheitToCelsius {
            labelDescriptionNonConvertedTemperature.text = "Farenheit"
            labelDescriptionConvertedTemperature.text = "Celsius"
        } else {
            labelDescriptionNonConvertedTemperature.text = "Celsius"
            labelDescriptionConvertedTemperature.text = "Farenheit"
        }
    }

    private func convertFarenheitToCelsius() -> Double {
        if let fahrenheit = Double(textFieldTemperature.text!) {
            let temp = Measurement<UnitTemperature>(value: fahrenheit , unit: .fahrenheit)
            return temp.converted(to: .celsius).value
        } else {
            return  -0.0
        }

    }

    private func convertCelsiusToFarenheit() -> Double {
        if let celsius = Double(textFieldTemperature.text!) {
            let temp = Measurement<UnitTemperature>(value: celsius , unit: .celsius)
            return temp.converted(to: .fahrenheit).value
        } else {
            return  -0.0
        }
    }
    
    private func convertTemperature() {
        if isFarenheitToCelsius {
            labelConvertedTemperature.text = numberFormatter.string(from: NSNumber(value: convertFarenheitToCelsius()))
        } else {
            labelConvertedTemperature.text = numberFormatter.string(from: NSNumber(value: convertCelsiusToFarenheit()))
        }
    }

    @IBAction func invertConversion() {
        isFarenheitToCelsius = !isFarenheitToCelsius
        setLabelNames()
        convertTemperature()
    }
    
    @IBAction func convertTemperatureFieldEditingChanged(_ textField: UITextField){
        convertTemperature()
    }

    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        textFieldTemperature.resignFirstResponder()
    }

}

extension ConversionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."

        let existingTextHasDecimalSeparator =  textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)


        let hasLettersInTextField = textField.text?.rangeOfCharacter(from: NSCharacterSet.letters)
        let teste = string.rangeOfCharacter(from: .letters)
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil, hasLettersInTextField == nil, teste == nil {
            return false
        } else {
            return true
        }
    }
}

extension ConversionViewController {
    //MARK - Silver Challenge : Dark Mode
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        verifyHour()
    }
    
    private func getHour() -> Int{
        return Calendar.current.component(.hour, from: Date())
    }
    
    private func verifyHour() {
        if getHour() > 18 || getHour() < 7 {
            setMode(color: getColor(from: .dark))
        } else {
            setMode(color: getColor(from: .light))
        }
    }
    
    private func setMode(color: UIColor) {
        self.view.backgroundColor = color
    }
    
    private func getColor(from mode: Mode) -> UIColor {
        if mode == Mode.dark {
            return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        } else {
            return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
}

enum Mode {
    case light
    case dark
}
