//
//  TabbarController.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController, TabViewOutput {
    
    var selectedItemTabHandler: ((UINavigationController) -> Void)?
    var selectedTagTabHandler: ((UINavigationController) -> Void)?
    var selectedMypageTabHandler: ((UINavigationController) -> Void)?
    
    lazy var itemTabNavigationController: UINavigationController = {
        guard let navigationController = viewControllers?[SelectTab.item.rawValue] as? UINavigationController else {
            let nav = UINavigationController()
            nav.tabBarItem = UITabBarItem(title: "投稿", image: nil, tag: SelectTab.item.rawValue)
            return nav
        }
        return navigationController
    }()
    
    lazy var tagTabNavigationController: UINavigationController = {
        guard let navigationController = viewControllers?[SelectTab.tag.rawValue] as? UINavigationController else {
            let nav = UINavigationController()
            nav.tabBarItem = UITabBarItem(title: "タグ", image: nil, tag: SelectTab.tag.rawValue)
            return nav
        }
        return navigationController
    }()
    
    lazy var mypageTabNavigationController: UINavigationController = {
        guard let navigationController = viewControllers?[SelectTab.mypage.rawValue] as? UINavigationController else {
            let nav = UINavigationController()
            nav.tabBarItem = UITabBarItem(title: "マイページ", image: nil, tag: SelectTab.mypage.rawValue)
            return nav
        }
        return navigationController
    }()
    
    private var currentIndex: Int = SelectTab.item.rawValue
    
    init(tab selected: SelectTab, selectedItemTabHandler: ((UINavigationController) -> Void)?,
         selectedTagTabHandler: ((UINavigationController) -> Void)?,
         selectedMypageTabHandler: ((UINavigationController) -> Void)?) {
        currentIndex = selected.rawValue
        self.selectedItemTabHandler = selectedItemTabHandler
        self.selectedTagTabHandler = selectedTagTabHandler
        self.selectedMypageTabHandler = selectedMypageTabHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        delegate = self
        selectedIndex = currentIndex
        if let viewController = customizableViewControllers?.first {
            tabBarController(self, didSelect: viewController)
        }
    }
    
    private func setupViewControllers() {
        viewControllers = [itemTabNavigationController, tagTabNavigationController, mypageTabNavigationController]
    }
    
    func changeTab(_ selectTab: SelectTab) {
        currentIndex = selectTab.rawValue
    }

}

extension TabbarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationController = viewControllers?[selectedIndex] as? UINavigationController,
            let selectedTab = SelectTab(rawValue: selectedIndex) else {
                return
        }
        
        switch selectedTab {
        case .item:
            selectedItemTabHandler?(navigationController)
        case .tag:
            selectedTagTabHandler?(navigationController)
        case .mypage:
            selectedMypageTabHandler?(navigationController)
        }
    }
    
}

extension TabbarController {
    
    enum SelectTab: Int {
        case item
        case tag
        case mypage
    }
    
}

