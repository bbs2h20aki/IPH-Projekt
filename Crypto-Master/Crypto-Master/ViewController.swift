//
//  ViewController.swift
//  Crypto-Master
//
//  Created by Fabian Kirchmann / BBS2H20A on 22.09.21.
//

import UIKit

class ViewController: UIViewController {

    let countries = ["Ceasar", "Vigenere", "AES"]
    let pickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textfield.inputView = pickerView
    }

    
    var e = true
    @IBOutlet weak var ausgabe: UILabel!
    @IBOutlet weak var eingabe: UITextView!
    @IBAction func segmented(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
             e = true
        }
        if sender.selectedSegmentIndex == 1 {
            e = false
        }
    }
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var key: UITextField!
    
   
    
    @IBAction func button(_ sender: UIButton) {
        let vigenere2 = Vigenere( key: key.text!)
        let ceasar2 = cesar()
       // let aes2 = aes()
        
        let choice = textfield.text!
        let message = eingabe.text!
        
        let s = Int(key.text!)!
        if e {
            switch choice {
            case "Ceasar":
                ausgabe.text = ceasar2.encrypt(message: message , shift: s)
                break
            case "Vigenere":
                ausgabe.text = vigenere2.encrypt(plainText: message)
                break
                
           // case "AES":
               
               // break
          
            default:
                ausgabe.text = ""
                
            }
        }
        if  e == false {
            switch choice {
            case "Ceasar":
                ausgabe.text = ceasar2.decrypt(message: message , shift: s)
                break
            case "Vigenere":
                ausgabe.text = vigenere2.decrypt(encryptedText: message)
                break
                
           // case "AES":
            
            case "": break
            
            default:
                ausgabe.text = ""
            }
        }
        
    }
    
    
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

