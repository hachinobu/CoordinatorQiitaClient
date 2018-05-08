//
//  Translatable.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation

protocol Translatable {
    associatedtype Input
    associatedtype Output
    
    func translate(input: Input) -> Output
}

extension Sequence {
    
    func translate<T: Translatable>(translatable: T) -> [T.Output] where Element == T.Input {
        return map { translatable.translate(input: $0) }
    }
    
}
