//
//  UserDetailTableCell.swift
//  MVVMC_QiitaClient
//
//  Created by Takahiro Nishinobu on 2017/08/17.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import UIKit
import Kingfisher

final class UserDetailTableCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var followTagListButton: UIButton!
    @IBOutlet weak var followeeUserCountLabel: UIButton!
    @IBOutlet weak var followerUserCountLabel: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    var tappedFollowTagList: (() -> Void)?
    var tappedFolloweeList: (() -> Void)?
    var tappedFollowerList: (() -> Void)?
    var tappedLogout: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.layer.masksToBounds = true
        logoutButton.layer.cornerRadius = 4.0
        logoutButton.layer.masksToBounds = true
        logoutButton.setTitle("ログアウト", for: .normal)
        logoutButton.addTarget(self, action: .tappedLogout, for: .touchUpInside)
        followTagListButton.addTarget(self, action: .tappedFollowTag, for: .touchUpInside)
        followeeUserCountLabel.addTarget(self, action: .tappedFollowee, for: .touchUpInside)
        followerUserCountLabel.addTarget(self, action: .tappedFollower, for: .touchUpInside)
    }
    
    func setupCell(with model: UserHeaderTableCellModel) {
        setupProfileImage(with: model.profileURL)
        userIdLabel.text = model.userId
        userNameLabel.text = model.userName
        companyLabel.text = model.company
        itemCountLabel.text = model.itemCount
        followeeUserCountLabel.setTitle(model.followeeUserCount, for: .normal)
        followerUserCountLabel.setTitle(model.followerUserCount, for: .normal)
        descriptionLabel.attributedText = model.description
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
    
    @objc func tappedFollowTag(_ sender: Any) {
        tappedFollowTagList?()
    }
    
    @objc func tappedFollowee(_ sender: Any) {
        tappedFolloweeList?()
    }
    
    @objc func tappedFollower(_ sender: Any) {
        tappedFollowerList?()
    }
    
    @objc func tappedLogout(_ sender: Any) {
        tappedLogout?()
    }

}

private extension Selector {
    static let tappedFollowTag = #selector(UserDetailTableCell.tappedFollowTag(_:))
    static let tappedFollowee = #selector(UserDetailTableCell.tappedFollowee(_:))
    static let tappedFollower = #selector(UserDetailTableCell.tappedFollower(_:))
    static let tappedLogout = #selector(UserDetailTableCell.tappedLogout(_:))
}



