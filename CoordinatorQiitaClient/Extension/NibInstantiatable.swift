//
//  NibInstantiatable.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

protocol NibInstantiatable {
    static var nibName: String { get }
    static var nibBundle: Bundle { get }
    static var nibOwner: Any? { get }
    static var nibOptions: [AnyHashable: Any]? { get }
    static var instantiateIndex: Int { get }
}

extension NibInstantiatable where Self: NSObject {
    static var nibName: String { return className }
    static var nibBundle: Bundle { return Bundle(for: self) }
    static var nibOwner: Any? { return self }
    static var nibOptions: [AnyHashable: Any]? { return nil }
    static var instantiateIndex: Int { return 0 }
}

extension NibInstantiatable where Self: UIView {
    static func instantiate() -> Self {
        let nib = UINib(nibName: nibName, bundle: nibBundle)
        return nib.instantiate(withOwner: nibOwner, options: nibOptions)[instantiateIndex] as! Self
    }
}

extension UIView: NibInstantiatable {}
