//
//  TwoViewController.swift
//  learning_swift
//
//  Created by 桑原慶之 on 2017/11/17.
//  Copyright © 2017年 KeishiKuwabara. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
