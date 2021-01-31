//
//  XCResultPath.swift
//  xccodecov
//  
//  Created by Mitsuru Nakada on 2020/11/14.
//  Copyright © 2020 Mitsuru Nakada. All rights reserved.
//

import Foundation

struct XCResultPath {
    let rawValue: String

    func isValid() -> Bool {
        (xcresultFilename as NSString).pathExtension == "xcresult"
    }

    var repoPath: String {
        var components = (rawValue as NSString).pathComponents
        components.removeFirst() // remove "/"
        components.removeLast() // remove "*.xcresult
        return "/" + components.joined(separator: "/")
    }

    var xcresultFilename: String {
        (rawValue as NSString).lastPathComponent
    }
}
