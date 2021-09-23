//
//  ceasar.swift
//  Crypto-Master
//
//  Created by Johannes Stümer / BBS2H20A on 23.09.21.
//

import Foundation

import UIKit

class cesar{

func encrypt(message: String, shift: Int) -> String {

    func shiftLetter(ucs: UnicodeScalar) -> UnicodeScalar {
        let firstLetter = Int(UnicodeScalar("A").value)
        let lastLetter = Int(UnicodeScalar("Z").value)
        let letterCount = lastLetter - firstLetter + 1

        let value = Int(ucs.value)
        switch value {
        case firstLetter...lastLetter:
            var offset = value - firstLetter
            offset += shift
            offset = (offset % letterCount + letterCount) % letterCount
            return UnicodeScalar(firstLetter + offset)!
        default:
            return ucs
        }
    }

    let msg = message.uppercased()
    return String(String.UnicodeScalarView(msg.unicodeScalars.map(shiftLetter)))
}

func decrypt(message: String, shift: Int) -> String {

    func deshiftLetter(ucs: UnicodeScalar) -> UnicodeScalar {
        let firstLetter = Int(UnicodeScalar("A").value)
        let lastLetter = Int(UnicodeScalar("Z").value)
        let letterCount = lastLetter - firstLetter + 1

        let value = Int(ucs.value)
        switch value {
        case firstLetter...lastLetter:
            var offset = value - firstLetter
            offset -= shift
            offset = (offset % letterCount + letterCount) % letterCount
            return UnicodeScalar(firstLetter + offset)!
        default:
            return ucs
        }
    }

    let msg = message.uppercased()
    return String(String.UnicodeScalarView(msg.unicodeScalars.map(deshiftLetter)))
}

}





