//
//  ProgressPresentableView.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/09.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol ProgressPresentableView: class {}

extension ProgressPresentableView where Self: UIViewController {
    
    func showProgress() {
        SVProgressHUD.show()
    }
    
    func hideProgress() {
        SVProgressHUD.dismiss()
    }
    
    func showErrorProgress(with error: Error) {
        SVProgressHUD.showError(withStatus: error.localizedDescription)
    }
    
    func showFeedbackProgress(with message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }
    
}
