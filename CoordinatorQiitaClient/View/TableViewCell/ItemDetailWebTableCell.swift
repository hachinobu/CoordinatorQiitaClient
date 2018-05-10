//
//  ItemDetailWebTableCell.swift
//  MVVMC_QiitaClient
//
//  Created by Takahiro Nishinobu on 2017/07/31.
//  Copyright © 2017年 hachinobu. All rights reserved.
//

import UIKit
import WebKit

final class ItemDetailWebTableCell: UITableViewCell {
    
    @IBOutlet weak var webView: WKWebView!
    var finishWebLoadHandler: ((CGFloat) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = self
    }
    
}

extension ItemDetailWebTableCell: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.readyState", completionHandler: { [weak self] (complete, error) in
            if complete != nil {
                self?.finishWebLoadHandler?(webView.scrollView.contentSize.height)
            }
        })
    }
    
}
