//
//  ItemDetailViewController.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/09.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit
import FlowKitManager
import Hydra

class ItemDetailViewController: UIViewController, ProgressPresentableView, ItemDetailViewOutput {

    private let itemId: String
    
    init(title: String, itemId: String) {
        self.itemId = itemId
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    var selectedUserHandler: ((String) -> Void)?
    var selectedLikeHandler: (() -> Bool)?
    var selectedLikeCountHandler: (() -> Void)?
    var deinitHandler: (() -> Void)?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
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
    
    private var contentsHeight: CGFloat = 0.0
    private var headerModel: ItemHeaderTableCellModel?
    private var contentsModel: ItemContentsTableCellModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchItemData()
    }
    
    deinit {
        deinitHandler?()
    }
    
    private func setupTableView() {
        let itemHeaderAdapter = TableAdapter<ItemHeaderTableCellModel, ItemDetailHeaderTableCell>()
        
        itemHeaderAdapter.on.dequeue = { [weak self] ctx in
            ctx.cell?.setupCell(with: ctx.model)
            
            ctx.cell?.tappedUserNameButtonHandler = { [weak self] in
                self?.selectedUserHandler?(ctx.model.userId)
            }
            
            ctx.cell?.tappedLikeCountButtonHandler = { [weak self] in
                self?.selectedLikeCountHandler?()
            }
            
            ctx.cell?.updateLikeStatusHandler = { [weak self] in
                guard let finishLogin = self?.selectedLikeHandler?(), finishLogin else {
                    return
                }
                if ctx.model.hasLike {
                    self?.removeLikeStatus()
                } else {
                    self?.putLikeStatus()
                }
            }
        }
        
        let itemContentsAdapter = TableAdapter<ItemContentsTableCellModel, ItemDetailWebTableCell>()
        
        itemContentsAdapter.on.dequeue = { [weak self] ctx in
            ctx.cell?.webView.loadHTMLString(ctx.model.htmlBody, baseURL: nil)
            ctx.cell?.finishWebLoadHandler = { [weak self] height in
                guard let strongSelf = self else {
                    return
                }
                if strongSelf.contentsHeight > 0.0 {
                    return
                }
                strongSelf.contentsHeight = height
                ctx.table?.reloadRows(at: [ctx.indexPath], with: .fade)
            }
        }
        
        itemContentsAdapter.on.rowHeight = { [weak self] _ -> CGFloat in
            return self?.contentsHeight ?? 0.0
        }
        
        director.register(adapters: [itemHeaderAdapter, itemContentsAdapter])
        
    }

}

extension ItemDetailViewController {
    
    private func fetchItemData() {
        let itemPromise = fetchItemPromise()
        let likeStatusPromise = fetchLikeStatusPromise()
        Promise<Void>.zip(itemPromise, likeStatusPromise).always { [weak self] in
            self?.showProgress()
            }.then { [weak self] (item, status) in
                let itemHeaderModel = ItemHeaderTableCellModelTranslator().translate(input: (item, status))
                let itemContentsModel = ItemContentsTableCellModelTranslator().translate(input: item)
                self?.headerModel = itemHeaderModel
                self?.contentsModel = itemContentsModel
                self?.director.add(models: [itemHeaderModel, itemContentsModel])
                self?.director.reloadData()
                self?.hideProgress()
            }.catch { [weak self] (error) in
                self?.showErrorProgress(with: error)
        }
    }
    
    private func fetchItemPromise() -> Promise<Item> {
        return Promise<Item> { [unowned self] resolve, reject, _ in
            ItemAPI.fetchItemByItemId(id: self.itemId, completion: { (item, error) in
                if let item = item {
                    resolve(item)
                } else {
                    reject(error!)
                }
            })
        }
    }
    
    private func fetchLikeStatusPromise() -> Promise<Bool> {
        return Promise<Bool> { [unowned self] (resolve, reject, _) in
            LikeUserAPI.fetchLikeStatusByItemId(itemId: self.itemId, completion: { (error) in
                let hasLike = error == nil
                resolve(hasLike)
            })
        }
    }
    
    private func putLikeStatus() {
        showProgress()
        LikeUserAPI.putLikeByItemId(itemId: itemId) { [weak self] (error) in
            guard let error = error else {
                self?.showFeedbackProgress(with: "いいねしました")
                self?.updateLike()
                return
            }
            self?.showErrorProgress(with: error)
        }
    }
    
    private func removeLikeStatus() {
        showProgress()
        LikeUserAPI.removeLikeByItemId(itemId: itemId) { [weak self] (error) in
            guard let error = error else {
                self?.showFeedbackProgress(with: "いいねを削除しました")
                self?.updateLike()
                return
            }
            self?.showErrorProgress(with: error)
        }
    }
    
    private func updateLike() {
        headerModel?.turnLikeStatus()
        director.removeAll()
        director.add(models: [headerModel!, contentsModel!])
        director.reloadData()
    }
    
}

