//
//  ViewController.swift
//  learning_swift
//
//  Created by 桑原慶之 on 2017/11/16.
//  Copyright © 2017年 KeishiKuwabara. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)

        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)

        viewControllers = tabs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tabs() -> [UIViewController] {
        let a = OneViewController()
        let an = UINavigationController(rootViewController: a)
        an.title = "TAB ONE"

        let b = TwoViewController()
        let bn = UINavigationController(rootViewController: b)
        bn.title = "TAB TWO"
        
        let c = ThreeViewController()
        let cn = UINavigationController(rootViewController: c)
        cn.title = "TAB THREE"

        let d = FourViewController()
        let dn = UINavigationController(rootViewController: d)
        dn.title = "TAB FOUR"
        
        let e = FiveViewController()
        let en = UINavigationController(rootViewController: e)
        en.title = "TAB FIVE"
        
        return [an, bn, cn, dn, en]
    }
}

