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
    @IBOutlet weak var eingabe: UITextField!
    @IBOutlet weak var erklaerung: UILabel!
    
    @IBAction func segmented(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
             e = true
        }
        if sender.selectedSegmentIndex == 1 {
            e = false
        }
    }
    

    @IBOutlet weak var key: UITextField!
    @IBOutlet weak var textfield: UITextField!
    
   
    
    @IBAction func button(_ sender: UIButton) {
        let vigenere2 = Vigenere( key: key.text!)
        let ceasar2 = cesar()
        
        let choice = textfield.text!
        let message = eingabe.text!
        
       
        if e {
            switch choice {
            case "Ceasar":
                let s = Int(key.text!)!
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
                let s = Int(key.text!)!
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
        if textfield.text == "Ceasar"{
        erklaerung.text = "Bei der Verschlüsselung wird jeder Buchstabe des Klartexts in Geheimtextbuchstaben abgebildet. Diese Abbildung ergibt sich, indem man die Zeichen eines geordneten Alphabets um eine bestimmte Anzahl zyklisch nach rechts verschiebt; zyklisch bedeutet, dass man beim Verschieben über Z hinaus wieder bei A anfangend weiterzählt."
        }
        if textfield.text == "Vigenere"{
        erklaerung.text = "Der Klartext wird in Einzelzeichen zerlegt und diese durch Geheimtextzeichen ersetzt, die mithilfe eines Kennworts aus mehreren unterschiedlichen Alphabeten des Vigenere-Quadrats ausgewählt werden. Dabei handelt es sich um eine quadratische Anordnung von untereinander stehenden verschobenen Alphabeten."
            key.placeholder = "Wort zum Verschlüsseln eingeben!"
        }
        if textfield.text == "AES"{
            erklaerung.text = "Bei der AES Verschlüsselung wird ein- und derselbe Schlüssel zum Ver- und Entschlüsseln verwendet. Das AES Verschlüsselungsverfahren ist von der AES Encryption Variante abhängig. Zunächst schreibt man jeden Block in eine Tabelle mit vier Zeilen. Die Anzahl der Spalten hängt dabei von der gewählten AES Variante ab und reicht von 4 (128 Bit) bis 8 (256 Bit). Beim AES Verfahren wird ein Block nicht nur einmal verschlüsselt. Verschiedene Teile des Schlüssels werden nacheinander angewendet. Die Anzahl dieser Runden   ist dabei von der Schlüssellänge und der Blockgröße abhängig."
        }
    }
}

