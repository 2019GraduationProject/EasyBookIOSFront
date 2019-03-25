//
//  DiscoverController.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/9.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

import UIKit
import Parchment

class CustomPagingView: PagingView {

    override func setupConstraints() {
        pageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}

// Create a custom paging view controller and override the view with
// our own custom subclass.
class CustomPagingViewController: PagingViewController<PagingIndexItem> {
    override func loadView() {
        view = CustomPagingView(
            options: options,
            collectionView: collectionView,
            pageView: pageViewController.view
        )
    }
}

class DiscoverController: UIViewController {

    // Create an instance of UIScrollView that we will be used to
    // "trick" the navigation bar to update.
    private let hiddenScrollView = UIScrollView()

    // Create an instance of our custom paging view controller that
    // does not setup any constraints for the menu view.
    private let pagingViewController = CustomPagingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = navigationController else { return }

        // Customize the menu to match the navigation bar color
        pagingViewController.borderOptions = .hidden
        pagingViewController.menuItemSize = .sizeToFit(minWidth: 150, height: 50)
        pagingViewController.menuBackgroundColor = UIColor(named: "themeColor")!
        pagingViewController.indicatorColor = UIColor.white
        pagingViewController.textColor = UIColor.lightGray
        pagingViewController.selectedTextColor = UIColor.white
        pagingViewController.indicatorOptions = .visible(
            height: 3,
            zIndex: Int.max,
            spacing: UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60),
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 3, right: 0)
        )

        // Add the "hidden" scroll view to the root of the UIViewController.
        view.addSubview(hiddenScrollView)
        hiddenScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hiddenScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hiddenScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hiddenScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hiddenScrollView.topAnchor.constraint(equalTo: view.topAnchor),
        ])

        // Add the PagingViewController and constrain it to all edges.
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)

        pagingViewController.dataSource = self

        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
        ])

        // Add the menu view as a subview to the navigation
        // controller and constrain it to the bottom of the navigation
        // bar. This is the best way I've found to make a view scroll
        // alongside the navigation bar.
        navigationController.view.addSubview(pagingViewController.collectionView)
        pagingViewController.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingViewController.collectionView.heightAnchor.constraint(equalToConstant: pagingViewController.menuItemSize.height),
            pagingViewController.collectionView.leadingAnchor.constraint(equalTo: navigationController.view.leadingAnchor),
            pagingViewController.collectionView.trailingAnchor.constraint(equalTo: navigationController.view.trailingAnchor),
            pagingViewController.collectionView.topAnchor.constraint(equalTo: navigationController.navigationBar.bottomAnchor),
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        pagingViewController.collectionView.isHidden = false
        
        // Running layout here fixes an issue where only the first
        // cell in the menu is shown initially.
        navigationController?.view.layoutIfNeeded()
        pagingViewController.view.layoutIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        guard let tableVC = pagingViewController.pageViewController.selectedViewController as? UITableViewController else { return }

        // When switching to another view controller, update the hidden
        // scroll view to match the current table view.
        hiddenScrollView.contentSize = tableVC.tableView.contentSize
        hiddenScrollView.contentInset = tableVC.tableView.contentInset
        hiddenScrollView.contentOffset = tableVC.tableView.contentOffset
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        pagingViewController.collectionView.isHidden = true
    }

}

extension DiscoverController: PagingViewControllerDataSource {

    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {

        let tableVC: UITableViewController!

        if index == 0 {
            tableVC = self.storyboard?.instantiateViewController(withIdentifier: "LocalDiscoverController") as! LocalDiscoverController
        } else {
            tableVC = self.storyboard?.instantiateViewController(withIdentifier: "GlobalDiscoverController") as! GlobalDiscoverController
        }

        // Inset the table view with the height of the menu height.
        let insets = UIEdgeInsets(top: pagingViewController.menuItemSize.height, left: 0, bottom: 0, right: 0)
        tableVC.tableView.scrollIndicatorInsets = insets
        tableVC.tableView.contentInset = insets
        
        return tableVC
    }

    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        if index == 0 {
            return PagingIndexItem(index: index, title: "组内/跨组事件") as! T
        } else {
            return PagingIndexItem(index: index, title: "全局事件") as! T
        }
    }

    func numberOfViewControllers<T>(in pagingViewController: PagingViewController<T>) -> Int {
        return 2
    }

}

extension DiscoverController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // When the current table view is scrolling, we update the
        // content offset of the hidden scroll view to trigger the
        // large titles to update.
        hiddenScrollView.contentOffset = scrollView.contentOffset
    }

}
