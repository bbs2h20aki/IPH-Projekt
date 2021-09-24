//
//  ViewController.swift
//  Crypto-Master
//
//  Created by Fabian Kirchmann / BBS2H20A on 22.09.21.
//

import UIKit
import Foundation
import CommonCrypto







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
                
            case "AES":
                ausgabe.text = encrypted?.base64EncodedString()
                break
          
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
                
            case "AES":
                ausgabe.text = decrypted?.base64EncodedString()
                break
            
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
            key.placeholder = "Zahl zum veschieben eingeben!"
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

class AES{
func crypt(operation: Int, algorithm: Int, options: Int, key: Data,

        initializationVector: Data, dataIn: Data) -> Data? {

    return key.withUnsafeBytes { keyUnsafeRawBufferPointer in

        return dataIn.withUnsafeBytes { dataInUnsafeRawBufferPointer in

            return initializationVector.withUnsafeBytes { ivUnsafeRawBufferPointer in


                let dataOutSize: Int = dataIn.count + kCCBlockSizeAES128*2

                let dataOut = UnsafeMutableRawPointer.allocate(byteCount: dataOutSize,

                    alignment: 1)

                defer { dataOut.deallocate() }

                var dataOutMoved: Int = 0

                let status = CCCrypt(CCOperation(operation), CCAlgorithm(algorithm),

                    CCOptions(options),

                    keyUnsafeRawBufferPointer.baseAddress, key.count,

                    ivUnsafeRawBufferPointer.baseAddress,

                    dataInUnsafeRawBufferPointer.baseAddress, dataIn.count,

                    dataOut, dataOutSize, &dataOutMoved)

                guard status == kCCSuccess else { return nil }

                return Data(bytes: dataOut, count: dataOutMoved)

            }

        }

    }

}

 
 

func randomGenerateBytes(count: Int) -> Data? {

    let bytes = UnsafeMutableRawPointer.allocate(byteCount: count, alignment: 1)

    defer { bytes.deallocate() }

    let status = CCRandomGenerateBytes(bytes, count)

    guard status == kCCSuccess else { return nil }

    return Data(bytes: bytes, count: count)

}
    
    
}

extension Data {
   

    func encryptAES256_CBC_PKCS7_IV(key: Data) -> Data? {

        guard let iv = aes.randomGenerateBytes(count: kCCBlockSizeAES128) else { return nil }
        
        guard let ciphertext = aes.crypt(operation: kCCEncrypt,

                                    algorithm: kCCAlgorithmAES,

                                    options: kCCOptionPKCS7Padding,

                                    key: key,

                                    initializationVector: iv,

                                    dataIn: self) else { return nil }

         

        return iv + ciphertext

    }



    func decryptAES256_CBC_PKCS7_IV(key: Data) -> Data? {

        guard count > kCCBlockSizeAES128 else { return nil }

        let iv = prefix(kCCBlockSizeAES128)

        let ciphertext = suffix(from: kCCBlockSizeAES128)

        return aes.crypt(operation: kCCDecrypt, algorithm: kCCAlgorithmAES,

            options: kCCOptionPKCS7Padding, key: key, initializationVector: iv,

            dataIn: ciphertext)

    }

}

let aes = AES()
let key = aes.randomGenerateBytes(count: 256/8)!
let vc = ViewController()

let ein = vc.eingabe.text
let superDuperSecret =  ein?.data(using: .utf8)!

let encrypted = superDuperSecret?.encryptAES256_CBC_PKCS7_IV(key: key)!

let decrypted = encrypted?.decryptAES256_CBC_PKCS7_IV(key: key)!

