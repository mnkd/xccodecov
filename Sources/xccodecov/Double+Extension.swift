//
//  Double+Extension.swift
//  xccodecov
//  
//  Created by Mitsuru Nakada on 2020/11/13.
//  Copyright © 2020 Mitsuru Nakada. All rights reserved.
//

import Foundation

extension Double {
    var toPercent: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
