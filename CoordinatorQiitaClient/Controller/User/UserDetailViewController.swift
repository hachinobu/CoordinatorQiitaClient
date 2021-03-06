//
//  UserDetailViewController.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit
import FlowKitManager
import Hydra

class UserDetailViewController: UIViewController, ProgressPresentableView, UserDetailViewOutput {
    var selectedFollowTagHandler: (() -> Void)?
    var selectedFolloweeHandler: (() -> Void)?
    var selectedFollowerHandler: (() -> Void)?
    var selectedItemHandler: ((String) -> Void)?
    var deinitHandler: (() -> Void)?
    
    private let userId: String
    
    init(title: String, userId: String) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        return tableView
    }()
    
    private lazy var director: TableDirector = {
        return TableDirector(tableView)
    }()
    
    private var currentPage: Int = 1
    private var itemModels: [ItemListTableCellModel] = []
    private var moreLoadData: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    deinit {
        deinitHandler?()
    }
    
    private func setupTableView() {
        let userHeaderAdapter = TableAdapter<UserHeaderTableCellModel ,UserDetailTableCell>()
        userHeaderAdapter.on.dequeue = { [weak self] ctx in
            ctx.cell?.setupCell(with: ctx.model)
            
            ctx.cell?.tappedFollowTagList = { [weak self] in
                self?.selectedFollowTagHandler?()
            }
            
            ctx.cell?.tappedFolloweeList = { [weak self] in
                self?.selectedFolloweeHandler?()
            }
            
            ctx.cell?.tappedFollowerList = { [weak self] in
                self?.selectedFollowerHandler?()
            }
            
            ctx.cell?.logoutButton.heightAnchor.constraint(equalToConstant: 0.0).isActive = true
            
        }
        
        let itemAdapter = TableAdapter<ItemListTableCellModel, ItemListTableCell>()
        itemAdapter.on.dequeue = { ctx in
            ctx.cell?.setupCell(with: ctx.model)
        }
        
        itemAdapter.on.willDisplay = { [weak self] ctx in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.itemModels.count == 0 {
                return
            }
            let border = strongSelf.itemModels.count - 1
            if ctx.indexPath.row == border && strongSelf.moreLoadData {
                strongSelf.fetchMoreItemData()
            }
        }
        
        itemAdapter.on.tap = { [weak self] ctx in
            self?.selectedItemHandler?(ctx.model.itemId)
            return .deselectAnimated
        }
        
        director.register(adapters: [userHeaderAdapter, itemAdapter])
    }
    
}

extension UserDetailViewController {
    
    private func fetchData() {
        let userDetailPromise = fetchUserDetailPromise()
        let itemListPromise = fetchItemsPromise()
        Promise<Void>.zip(userDetailPromise, itemListPromise).always { [weak self] in
            self?.showProgress()
            }.then { [weak self] (user, items) in
                self?.itemModels = items
                self?.director.add(models: [user])
                self?.director.add(models: items)
                self?.director.reloadData()
                self?.hideProgress()
            }.catch { [weak self] (error) in
                self?.showErrorProgress(with: error)
        }
    }
    
    private func fetchMoreItemData() {
        fetchItemsPromise().always { [weak self] in
            self?.showProgress()
            }.then { [weak self] (items) in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.itemModels = strongSelf.itemModels + items
                strongSelf.director.remove(section: 1)
                strongSelf.director.add(models: strongSelf.itemModels)
                strongSelf.director.reloadData()
                strongSelf.hideProgress()
        }
    }
    
    private func fetchUserDetailPromise() -> Promise<UserHeaderTableCellModel> {
        return Promise<UserHeaderTableCellModel> { [weak self] resolve, reject, _ in
            UserAPI.fetchUserDetailByUserId(id: self!.userId, completion: { (user, error) in
                guard let user = user else {
                    reject(error!)
                    return
                }
                let userModel = UserHeaderTableCellModelTranslator().translate(input: user)
                resolve(userModel)
            })
        }
    }
    
    private func fetchItemsPromise() -> Promise<[ItemListTableCellModel]> {
        return Promise<[ItemListTableCellModel]> { [weak self] resolve, reject, _ in
            ItemAPI.fetchItemsByUserId(id: self!.userId, page: self!.currentPage, perPage: 20, completion: { (items, error) in
                guard let items = items else {
                    reject(error!)
                    return
                }
                if items.count == 0 {
                    self?.moreLoadData = false
                    resolve([])
                    return
                }
                self?.currentPage = self!.currentPage + 1
                let models = items.translate(translatable: ItemListTableCellModelTranslator())
                resolve(models)
            })
        }
    }
    
    
}

