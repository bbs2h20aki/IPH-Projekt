//
//  ViewController.swift
//  Crypto-Master
//
//  Created by Fabian Kirchmann / BBS2H20A on 22.09.21.
//

import UIKit

class ViewController: UIViewController {

    let countries = ["Ceasar", "Vegenere", "AES"]
    
    let pickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textfield.inputView = pickerView
    }

 
    @IBOutlet weak var textfield: UITextField!
    
    
}
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textfield.text = countries[row]
        textfield.resignFirstResponder()
    }
}

