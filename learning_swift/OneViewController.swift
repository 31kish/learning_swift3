//
//  OneViewController.swift
//  learning_swift
//
//  Created by 桑原慶之 on 2017/11/17.
//  Copyright © 2017年 KeishiKuwabara. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    var tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        hidesBarsWithScrollView(scrollView: tableView, hidden: false, hiddenTop: true, hiddenBottom: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        _ = QiitaArticleAPI.getItems { (article, error) in
            print(article)
            print(error)
        }
        
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }

    func hidesBarsWithScrollView(scrollView: UIScrollView, hidden: Bool, hiddenTop: Bool, hiddenBottom: Bool) {
        
        var tabBarController: UITabBarController
        var navigationController: UINavigationController
        var inset = scrollView.contentInset
        
        if let t = self.tabBarController {
            tabBarController = t
        } else {
            tabBarController = UITabBarController()
        }

        if let n = self.navigationController {
            navigationController = n
        } else {
            navigationController = UINavigationController()
        }

        var tabBarRect = tabBarController.tabBar.frame
        var navBarRect = navigationController.navigationBar.frame
        let tabBarHeight = tabBarRect.size.height
        let navBarHeight = navBarRect.size.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let controllerHeight = view.frame.size.height
        
        if hidden {
            if hiddenTop {
                navBarRect.origin.y = navBarRect.origin.y - (navBarHeight + statusBarHeight)
                inset.top = 0
            }
            
            if hiddenBottom {
                tabBarRect.origin.y = controllerHeight
                inset.bottom = 0
            }
        } else {
            navBarRect.origin.y = statusBarHeight
            inset.top = navBarHeight + statusBarHeight
            tabBarRect.origin.y = controllerHeight - tabBarHeight
            inset.bottom = tabBarHeight
        }
        
        UIView.animate(withDuration: TimeInterval(UINavigationControllerHideShowBarDuration)) {
            scrollView.contentInset = inset
            scrollView.scrollIndicatorInsets = inset
            tabBarController.tabBar.frame = tabBarRect
            navigationController.navigationBar.frame = navBarRect
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension OneViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = String(indexPath.row)
        cell.detailTextLabel?.text = "detail" + String(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
}

extension OneViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension OneViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0 {
            hidesBarsWithScrollView(scrollView: scrollView, hidden: true, hiddenTop: true, hiddenBottom: true)
        } else {
            hidesBarsWithScrollView(scrollView: scrollView, hidden: false, hiddenTop: true, hiddenBottom: true)
        }
    }
}
