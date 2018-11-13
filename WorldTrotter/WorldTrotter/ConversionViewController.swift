//
// Created by Cast Group on 13/11/2018.
// Copyright (c) 2018 hoffsilva. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {

    var isFarenheitToCelsius = true
    
    @IBOutlet weak var textFieldTemperature: UITextField!
    @IBOutlet weak var labelDescriptionNonConvertedTemperature: UILabel!
    @IBOutlet weak var labelConvertedTemperature: UILabel!
    @IBOutlet weak var labelDescriptionConvertedTemperature: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelNames()
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

    @IBAction func invertConversion() {
        isFarenheitToCelsius = !isFarenheitToCelsius
        setLabelNames()
    }
    
    @IBAction func convertTemperatureFieldEditingChanged(_ textField: UITextField){
        if isFarenheitToCelsius {
            labelConvertedTemperature.text = "\(convertFarenheitToCelsius())"
        } else {
            labelConvertedTemperature.text = "\(convertCelsiusToFarenheit())"
        }
    }

    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        textFieldTemperature.resignFirstResponder()
    }


 
}
