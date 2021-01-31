//
//  Stats.swift
//  xccodecov
//  
//  Created by Mitsuru Nakada on 2020/11/13.
//  Copyright © 2020 Mitsuru Nakada. All rights reserved.
//

import Foundation
import XCResultKit

struct Stats {
    let target: CodeCoverageTarget
    let projectPath: String

    struct Result {
        let fileCount: Int
        let lineCoverage: Double
        var score: Double { lineCoverage / Double(fileCount) }
        var percent: String { score.toPercent }
    }

    func lineCoverage(layerName: String) -> Result {
        let filtered = target.files.filter {
            $0.path.replacingOccurrences(of: projectPath, with: "").hasPrefix("/\(layerName)")
        }

        let lineCoverage = filtered.reduce(0) { $0 + $1.lineCoverage }
        return Result(fileCount: filtered.count, lineCoverage: lineCoverage)
    }
}
