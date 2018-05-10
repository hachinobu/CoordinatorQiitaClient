//
//  LikeUserListViewController.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/10.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit
import FlowKitManager

class LikeUserListViewController: UIViewController, ProgressPresentableView, UserListViewOutput {
    
    var selectedUserHandler: ((String) -> Void)?
    var deinitHandler: (() -> Void)?
    private var itemId: String
    
    init(title: String, itemId: String) {
        self.itemId = itemId
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
    private var models: [UserListTableCellModel] = []
    private var moreLoadData: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchUsers()
    }
    
    private func setupTableView() {
        let userItemAdapter = TableAdapter<UserListTableCellModel ,UserListTableCell>()
        userItemAdapter.on.dequeue = { ctx in
            ctx.cell?.setupCell(with: ctx.model)
        }
        
        userItemAdapter.on.willDisplay = { [unowned self] ctx in
            if self.models.count == 0 {
                return
            }
            let border = self.models.count - 1
            if ctx.indexPath.row == border && self.moreLoadData {
                self.fetchUsers()
            }
        }
        
        userItemAdapter.on.tap = { [unowned self] ctx in
            self.selectedUserHandler?(ctx.model.userId)
            return .deselectAnimated
        }
        
        userItemAdapter.on.rowHeight = { ctx in
            return 60.0
        }
        
        director.register(adapter: userItemAdapter)
    }
    
    private func fetchUsers() {
        showProgress()
        LikeUserAPI.fetchLikeUsersByItemId(itemId: itemId, page: currentPage, perPage: 20) { [weak self] (users, error) in
            guard let likeUsers = users, let strongSelf = self else {
                return
            }
            guard likeUsers.count > 0 else {
                strongSelf.hideProgress()
                strongSelf.moreLoadData = false
                return
            }
            strongSelf.currentPage = strongSelf.currentPage + 1
            let users = likeUsers.compactMap { $0.user }
            let newModels = users.translate(translatable: UserListTableCellModelTranslator())
            strongSelf.models = strongSelf.models + newModels
            strongSelf.director.removeAll()
            strongSelf.director.add(models: strongSelf.models)
            strongSelf.director.reloadData()
            strongSelf.hideProgress()
        }
    }

}
