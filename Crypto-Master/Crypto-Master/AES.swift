//
//  AES.swift
//  Crypto-Master
//
//  Created by Fabian Kirchmann / BBS2H20A on 23.09.21.
//

/*
import UIKit
import Foundation
import CommonCrypto




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

    
    func decryptAES256_CBC_PKCS7_IV(key: Data) -> Data? {
        guard count > kCCBlockSizeAES128 else { return nil }
        let iv = prefix(kCCBlockSizeAES128)
        let ciphertext = suffix(from: kCCBlockSizeAES128)
        return crypt(operation: kCCDecrypt, algorithm: kCCAlgorithmAES,
            options: kCCOptionPKCS7Padding, key: key, initializationVector: iv,
            dataIn: ciphertext)
    }
}


extension Data {
    func encryptAES256_CBC_PKCS7_IV(key: Data) -> Data? {
        guard let iv = randomGenerateBytes(count: kCCBlockSizeAES128) else { return nil }
        guard let ciphertext = crypt(operation: kCCEncrypt,
                                    algorithm: kCCAlgorithmAES,
                                    options: kCCOptionPKCS7Padding,
                                    key: key,
                                    initializationVector: iv,
                                    dataIn: self) else { return nil }
        
        return iv + ciphertext
    }


let key = randomGenerateBytes(count: 256/8)!
let superDuperSecret = "The quick brown fox jumps over the lazy dog".data(using: .utf8)!
let encrypted = superDuperSecret.encryptAES256_CBC_PKCS7_IV(key: key)!
let decrypted = encrypted.decryptAES256_CBC_PKCS7_IV(key: key)!



*/
