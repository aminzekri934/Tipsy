//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.00
    var finalResult = "0.0"
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        //dimiss the keyboard
        billTextField.endEditing(true)
        
        //Get the current title of the button that was pressed.
        let buttonTitle = sender.currentTitle!
        
        //Remove the last character (%) from the title then turn it back into a String.
        let buttonTitleMinusPercentSign =  String(buttonTitle.dropLast())
        
        //Turn the String into a Double.
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
        
        //Divide the percent expressed out of 100 into a decimal e.g. 10 becomes 0.1
        tip = buttonTitleAsANumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        //Get the text the user typed in the billTextField
                let bill = billTextField.text!
                
                //If the text is not an empty String ""
                if bill != "" {
                    
                    //Turn the bill from a String e.g. "123.50" to an actual String with decimal places.
                    //e.g. 125.50
                    billTotal = Double(bill) ?? 0.00
                    
                    //Multiply the bill by the tip percentage and divide by the number of people to split the bill.
                    let result = billTotal * (1 + tip) / Double(numberOfPeople)
                    
                    //Round the result to 2 decimal places and turn it into a String.
                    finalResult  = String(format: "%.2f", result)
                    self.performSegue(withIdentifier: "goToResult", sender: self)
                }
    }
    //This method gets triggered just before the segue starts.
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            //If the currently triggered segue is the "goToResults" segue.
            if segue.identifier == "goToResult" {
                
                //Get hold of the instance of the destination VC and type cast it to a ResultViewController.
                let destinationVC = segue.destination as! ResultsViewController
                
                //Set the destination ResultsViewController's properties.
                destinationVC.result = finalResult
                destinationVC.tip = Int(tip * 100)
                destinationVC.split = numberOfPeople
            }
        }
}

