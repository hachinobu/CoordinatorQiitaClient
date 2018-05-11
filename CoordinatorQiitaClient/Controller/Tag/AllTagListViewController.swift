//
//  AllTagListViewController.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/11.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit
import FlowKitManager

class AllTagListViewController: UIViewController, ProgressPresentableView, TagListViewOutput {

    var selectedTagHandler: ((String) -> Void)?
    var deinitHandler: (() -> Void)?
    
    init(title: String) {
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
    private var models: [TagListTableCellModel] = []
    private var moreLoadData: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchTags()
    }
    
    deinit {
        deinitHandler?()
    }
    
    private func setupTableView() {
        let tagAdapter = TableAdapter<TagListTableCellModel, TagListTableCell>()
        tagAdapter.on.dequeue = { ctx in
            ctx.cell?.setupCell(with: ctx.model)
        }
        
        tagAdapter.on.willDisplay = { [weak self] ctx in
            if self == nil {
                return
            }
            if self!.models.count == 0 {
                return
            }
            let border = self!.models.count - 1
            if ctx.indexPath.row == border && self!.moreLoadData {
                self!.fetchTags()
            }
        }
        
        tagAdapter.on.tap = { [weak self] ctx in
            self?.selectedTagHandler?(ctx.model.tagId)
            return .deselectAnimated
        }
        
        tagAdapter.on.rowHeight = { ctx in
            return 80.0
        }
        
        director.register(adapter: tagAdapter)
    }
    
    private func fetchTags() {
        showProgress()
        TagAPI.fetchAllTags(page: currentPage, perPage: 20, sort: .count) { [weak self] (tags, error) in
            guard let tags = tags else {
                self?.showErrorProgress(with: error!)
                return
            }
            guard tags.count > 0 else {
                self?.hideProgress()
                self?.moreLoadData = false
                return
            }
            if self == nil {
                return
            }
            self!.currentPage = self!.currentPage + 1
            let newModels = tags.translate(translatable: TagListTableCellModelTranslator())
            self?.models = self!.models + newModels
            self?.director.removeAll()
            self?.director.add(models: self!.models)
            self?.director.reloadData()
            self?.hideProgress()
        }
    }

}
