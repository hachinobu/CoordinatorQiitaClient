//
//  Sequence+Ex.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

extension Sequence where Element: Hashable {
    var uniqueElements: [Element] {
        return Array(Set(self))
    }
}

extension Sequence where Element: Equatable {
    var uniqueElements: [Element] {
        return self.reduce([]) { (uniqueElements, element) in
            uniqueElements.contains(element) ?
                uniqueElements : uniqueElements + [element]
        }
    }
}
