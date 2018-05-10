//
//  UserListTableCell.swift
//  MVVMC_QiitaClient
//
//  Created by Takahiro Nishinobu on 2017/08/21.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import UIKit
import Kingfisher

final class UserListTableCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.layer.masksToBounds = true
    }
    
    func setupCell(with model: UserListTableCellModel) {
        setupProfileImage(with: model.profileURL)
        userNameLabel.text = model.userName
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
    
}
