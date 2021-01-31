//
//  String+Extension.swift
//  xccodecov
//  
//  Created by Mitsuru Nakada on 2020/11/13.
//  Copyright © 2020 Mitsuru Nakada. All rights reserved.
//

import Foundation

// https://stackoverflow.com/questions/32338137/padding-a-swift-string-for-printing
extension String {
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(self.suffix(toLength))
        }
    }

    func deleteSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}
