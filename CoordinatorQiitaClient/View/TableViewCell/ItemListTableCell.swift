//
//  ItemListTableCell.swift
//  MVVMC_QiitaClient
//
//  Created by Takahiro Nishinobu on 2017/07/25.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import UIKit
import Kingfisher

class ItemListTableCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    private var userId: String?
    var tappedUserHandler: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.layer.masksToBounds = true
        profileImageButton.addTarget(self, action: .tappedUserIcon, for: .touchUpInside)
    }
    
    func setupCell(with model: ItemListTableCellModel) {
        setupProfileImage(with: model.profileURL)
        userNameLabel.text = model.userName
        likeCountLabel.text = model.likeCount
        titleLabel.attributedText = model.title
        tagLabel.text = model.tag
        userId = model.userId
    }
    
    private func setupProfileImage(with url: URL?) {
        guard let url = url else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        profileImageView.kf.indicatorType = .activity
        profileImageView.kf.setImage(with: resource, placeholder: nil,
                                     options: [.transition(ImageTransition.fade(1.0)), .cacheMemoryOnly],
                                     progressBlock: nil, completionHandler: nil)
    }
    
    @objc func tappedUserIcon(_ sender: Any) {
        tappedUserHandler?(userId!)
    }
    
}

private extension Selector {
    static let tappedUserIcon = #selector(ItemListTableCell.tappedUserIcon(_:))
}

