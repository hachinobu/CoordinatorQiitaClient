//
//  TagListTableCell.swift
//  MVVMC_QiitaClient
//
//  Created by Takahiro Nishinobu on 2017/08/29.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import UIKit
import Kingfisher

final class TagListTableCell: UITableViewCell {
    
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var tagCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagImageView.layer.cornerRadius = 8.0
        tagImageView.layer.masksToBounds = true
    }
    
    func setupCell(with model: TagListTableCellModel) {
        setupTagImage(with: model.tagImageURL)
        tagNameLabel.text = model.tagName
        tagCountLabel.text = model.tagCountInfo
    }
    
    private func setupTagImage(with url: URL?) {
        guard let url = url else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        tagImageView.kf.indicatorType = .activity
        tagImageView.kf.setImage(with: resource, placeholder: nil,
                                     options: [.transition(ImageTransition.fade(1.0)), .cacheMemoryOnly],
                                     progressBlock: nil, completionHandler: nil)
    }
    
}
