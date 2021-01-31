//
//  Reporter.swift
//  xccodecov
//  
//  Created by Mitsuru Nakada on 2020/11/13.
//  Copyright © 2020 Mitsuru Nakada. All rights reserved.
//

import Foundation
import XCResultKit

struct Reporter {
    let projectName: String
    let xcresultPath: XCResultPath
    let config: Configration
    let zeroCoverageFiles: Bool
    private var xcresultName: String { xcresultPath.xcresultFilename }

    func report() {
        let url = URL(fileURLWithPath: xcresultPath.rawValue)
        let resultFile = XCResultFile(url: url)

        guard let codeCoverage = resultFile.getCodeCoverage() else {
            print("failed to get a code coverage")
            return
        }

        stats(codeCoverage)
    }

    private func stats(_ coverage: CodeCoverage) {
        print("")
        print("Total Coverage: \(coverage.lineCoverage.toPercent)")
        coverage.targets.forEach { statsTarget($0) }
    }

    private func statsTarget(_ target: CodeCoverageTarget) {
        if zeroCoverageFiles {
            let files = target.files.filter { $0.coveredLines == 0 }
            statsAllFiles(files)
        } else {
            statsCategory(target)
            statsFileSuffix("ViewModel.swift", target: target)
            statsFileSuffix("ViewController.swift", target: target)

            let files = target.files.filter { $0.coveredLines > 0 }
            statsAllFiles(files)
        }
    }

    private func statsFileSuffix(_ fileSuffix: String, target: CodeCoverageTarget) {
        let filtered = target.files.filter { $0.path.hasSuffix(fileSuffix) }
        let lineCoverage = filtered.reduce(0) { $0 + $1.lineCoverage }
        let result = Stats.Result(fileCount: filtered.count, lineCoverage: lineCoverage)

        print("")
        print("\(fileSuffix)")
        print("  \(result.percent) | \(filtered.count)/\(target.files.count)")
    }

    private func statsCategory(_ target: CodeCoverageTarget) {
        let stats = Stats(target: target, projectPath: "\(xcresultPath.repoPath)/\(projectName)")
        let categories = config.categories ?? []
        guard !categories.isEmpty else { return }

        let maxLength = categories.max(by: { $1.count > $0.count })?.count ?? 0

        print("")
        print("Category:")
        categories.forEach {
            let result = stats.lineCoverage(layerName: $0)
            let category = $0.padding(toLength: maxLength, withPad: " ", startingAt: 0)
            let percent = result.percent.leftPadding(toLength: 4, withPad: " ")
            let files = "\(result.fileCount)/\(target.files.count)".leftPadding(toLength: 7, withPad: " ")

            print("\(category) \(percent) | \(files)")
        }
    }

    private func statsAllFiles(_ files: [CodeCoverageFile]) {
        let sorted = files.sorted { file1, file2 in file1.path < file2.path }
        let results = sorted.map { statsFile($0) }
        let maxLength = results.max { $0.path.count < $1.path.count }?.path.count ?? 0
        let separator = "-".padding(toLength: maxLength + 5, withPad: "-", startingAt: 0)

        print("")
        print(separator)
        print("\(files.count) files")
        print(separator)

        results.forEach {
            let path = $0.path.padding(toLength: maxLength, withPad: " ", startingAt: 0)
            let percent = $0.lineCoverage.toPercent.leftPadding(toLength: 4, withPad: " ")
            print("\(path) \(percent)")
        }
    }

    private func statsFile(_ file: CodeCoverageFile) -> (path: String, lineCoverage: Double) {
        var path = file.path.replacingOccurrences(of: xcresultPath.repoPath, with: "")
        path = path.replacingOccurrences(of: "/\(projectName)", with: "")
        return (path, file.lineCoverage)
    }
}
