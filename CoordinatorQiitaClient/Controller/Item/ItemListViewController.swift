//
//  ItemListViewController.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/08.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit
import FlowKitManager
import Kingfisher

class ItemListViewController: UIViewController, ItemListViewOutput, ProgressPresentableView {
    
    var selectedItemHandler: ((String) -> Void)?
    var selectedUserHandler: ((String) -> Void)?
    var deinitViewHandler: (() -> Void)?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.refreshControl = self.refreshControl
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: .refreshData, for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var director: TableDirector = {
        return TableDirector(tableView)
    }()
    
    private var currentPage: Int = 1
    private var models: [ItemListTableCellModel] = []
    

    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchItems()
    }
    
    deinit {
        deinitViewHandler?()
    }
    
    @objc func refreshData() {
        KingfisherManager.shared.cache.clearMemoryCache()
        models = []
        currentPage = 1
        fetchItems()
        refreshControl.endRefreshing()
    }
    
    private func setupTableView() {
        let itemAdapter = TableAdapter<ItemListTableCellModel, ItemListTableCell>()
        
        itemAdapter.on.dequeue = { ctx in
            ctx.cell?.setupCell(with: ctx.model)
            ctx.cell?.tappedUserHandler = { [weak self] userId in
                self?.selectedUserHandler?(userId)
            }
        }
        
        itemAdapter.on.willDisplay = { [unowned self] ctx in
            if self.models.count == 0 {
                return
            }
            let border = self.models.count - 1
            if ctx.indexPath.row == border {
                self.fetchItems()
            }
        }
        
        itemAdapter.on.tap = { [unowned self] ctx in
            self.selectedItemHandler?(ctx.model.itemId)
            return .deselectAnimated
        }
        
        director.register(adapter: itemAdapter)
        
    }
    
    private func fetchItems() {
        showProgress()
        ItemAPI.fetchItemsByPageInfo(page: currentPage, perPage: 20) { [weak self] (items, error) in
            guard let items = items, let strongSelf = self else {
                return
            }
            strongSelf.currentPage = strongSelf.currentPage + 1
            let newModels = items.translate(translatable: ItemListTableCellModelTranslator())
            strongSelf.models = strongSelf.models + newModels
            strongSelf.director.removeAll()
            strongSelf.director.add(models: strongSelf.models)
            strongSelf.director.reloadData()
            strongSelf.hideProgress()
        }
    }
    
}

private extension Selector {
    static let refreshData = #selector(ItemListViewController.refreshData)
}

