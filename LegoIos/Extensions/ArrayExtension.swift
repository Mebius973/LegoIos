//
//  ArrayExtension.swift
//  LegoIos
//
//  Created by Mebius on 13/02/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func distinct() {
        self = self.removingDuplicates()
    }
}
