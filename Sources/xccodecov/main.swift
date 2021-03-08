//
//  main.swift
//  
//  
//  Created by Mitsuru Nakada on 2020/11/13.
//  Copyright © 2020 Mitsuru Nakada. All rights reserved.
//

import Foundation
import ArgumentParser

struct XCCodeCov: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "xccodecov",
        abstract: "report code coverage with *.xcresult",
        discussion: "",
        version: "0.2.0",
        shouldDisplay: true,
        helpNames: [.long, .short]
    )

    @Argument(help: "/path/to/*.xcresult")
    var path: String

    @Option(name: .shortAndLong, help: "target prefix")
    var targetPrefix: String

    @Option(name: .shortAndLong, help: "path to configration file")
    var configPath: String?

    @Flag(name: .shortAndLong, help: "show only files which is 0% coverage")
    var zeroCoverageFiles = false

    func run() throws {
        print("\(path)")

        let xcresultPath = XCResultPath(rawValue: path.deleteSuffix("/"))
        guard !path.isEmpty, xcresultPath.isValid() else {
            return
        }

        let config = Configration(path: configPath ?? "") ?? .default

        Reporter(
            targetPrefix: targetPrefix,
            xcresultPath: xcresultPath,
            config: config,
            zeroCoverageFiles: zeroCoverageFiles
        )
        .report()
    }
}

XCCodeCov.main()
