//
//  ItemDetailHeaderTableCell.swift
//  MVVMC_QiitaClient
//
//  Created by Nishinobu.Takahiro on 2017/08/10.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import UIKit
import Kingfisher

class ItemDetailHeaderTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var updateLikeStatusHandler: (() -> Void)?
    var tappedUserNameButtonHandler: (() -> Void)?
    var tappedLikeCountButtonHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.layer.masksToBounds = true
        likeButton.layer.cornerRadius = 4.0
        likeButton.layer.masksToBounds = true
        userNameButton.addTarget(self, action: .tappedUserNameButton, for: .touchUpInside)
        let likeCountTap = UITapGestureRecognizer(target: self, action: .tappedLikeCountButton)
        likeCountLabel.addGestureRecognizer(likeCountTap)
        likeCountLabel.isUserInteractionEnabled = true
        likeButton.addTarget(self, action: .tappedLikeButton, for: .touchUpInside)
    }
    
    func setupCell(with model: ItemHeaderTableCellModel) {
        setupProfileImage(with: model.profileURL)
        titleLabel.attributedText = model.title
        tagLabel.text = model.tag
        userNameButton.setTitle(model.userId, for: .normal)
        likeCountLabel.text = model.likeCount
        let likeButtonTitle = model.hasLike ? "いいね済み" : "いいね"
        likeButton.setTitle(likeButtonTitle, for: .normal)
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
    
    @objc func tappedLikeButton(_ sender: Any) {
        updateLikeStatusHandler?()
    }
    
    @objc func tappedUserNameButton(_ sender: Any) {
        tappedUserNameButtonHandler?()
    }
    
    @objc func tappedLikeCountButton(_ sender: Any) {
        tappedLikeCountButtonHandler?()
    }
    
}

private extension Selector {
    static let tappedLikeButton = #selector(ItemDetailHeaderTableCell.tappedLikeButton(_:))
    static let tappedUserNameButton = #selector(ItemDetailHeaderTableCell.tappedUserNameButton(_:))
    static let tappedLikeCountButton = #selector(ItemDetailHeaderTableCell.tappedLikeCountButton(_:))
}

