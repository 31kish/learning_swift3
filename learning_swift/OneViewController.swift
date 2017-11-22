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
    var tableDataSource = [Article?]()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        hidesBarsWithScrollView(scrollView: tableView, hidden: false, hiddenTop: true, hiddenBottom: true)
        
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        _ = QiitaArticleAPI.getItems { [weak self] (items, error) in
            if let e = error {
                print(e)
                return
            }
            
            self?.tableDataSource = items
            self?.tableView.reloadData()
        }
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
        cell.textLabel?.text = tableDataSource[indexPath.row]?.title
        cell.detailTextLabel?.text = tableDataSource[indexPath.row]?.user?.id
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.count
    }
}

extension OneViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = tableDataSource[indexPath.row]

        let alertController = UIAlertController(title: selectedData?.title, message: selectedData?.urlStr, preferredStyle: .alert)

        let positiveAction = UIAlertAction(title: "Open Safari", style: .default) { (action: UIAlertAction) in
            let url = URL(string: selectedData?.urlStr as String!)!

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }

            tableView.deselectRow(at: indexPath, animated: true)
        }

        let negativeAction = UIAlertAction(title: "Close", style: .cancel) { (action: UIAlertAction) in
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        alertController.addAction(positiveAction)
        alertController.addAction(negativeAction)

        present(alertController, animated: true, completion: nil)
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
