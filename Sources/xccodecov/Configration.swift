//
//  Configration.swift
//  xccodecov
//  
//  Created by Mitsuru Nakada on 2021/01/31.
//  Copyright © 2021 Goodpatch. All rights reserved.
//

import Foundation
import Yams

struct Configration: Codable {
    let categories: [String]?

    init?(path: String) {
        guard !path.isEmpty else {
            return nil
        }

        do {
            let url = URL(fileURLWithPath: path)
            let string = try String(contentsOf: url, encoding: .utf8)

            let decoder = YAMLDecoder()
            let decoded = try decoder.decode(Configration.self, from: string, userInfo: [:])
            self.categories = decoded.categories
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    init(categories: [String]) {
        self.categories = categories
    }

    static var `default`: Configration {
        Configration(categories: [])
    }
}
