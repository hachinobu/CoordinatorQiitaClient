//
//  LoginView.swift
//  CoordinatorQiitaClient
//
//  Created by Takahiro Nishinobu on 2018/05/07.
//  Copyright © 2018年 hachinobu. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var skipAuthButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loginButton.layer.cornerRadius = 4.0
    }
    
}
