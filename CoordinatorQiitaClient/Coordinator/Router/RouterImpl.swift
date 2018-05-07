//
//  RouterImpl.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

final class RouterImpl: Router {
    
    typealias CompletionHandler = (() -> Void)
    
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController: CompletionHandler]
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        self.completions = [:]
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func setRoot(_ presentable: Presentable?, hideBar: Bool) {
        guard let presentController = presentable?.toPresent() else {
            return
        }
        rootController?.setViewControllers([presentController], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRoot(animated: Bool) {
        guard let controllers = rootController?.popToRootViewController(animated: animated) else {
            return
        }
        controllers.forEach { runCompletion($0) }
    }
    
    func present(_ presentable: Presentable?, animated: Bool) {
        guard let controller = presentable?.toPresent() else {
            return
        }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ presentable: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard let controller = presentable?.toPresent(), (controller as? UINavigationController) == nil else {
            return
        }
        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        guard let controller = rootController?.popViewController(animated: animated) else {
            return
        }
        runCompletion(controller)
    }
    
    private func runCompletion(_ controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }
        completion()
        completions.removeValue(forKey: controller)
    }
    
}
