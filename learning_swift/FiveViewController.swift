//
//  FiveViewController.swift
//  learning_swift
//
//  Created by 桑原慶之 on 2017/11/17.
//  Copyright © 2017年 KeishiKuwabara. All rights reserved.
//

import UIKit

class FiveViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
