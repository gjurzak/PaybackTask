//
//  PBNavigationController.swift
//  Payback
//
//  Created by Grzegorz Jurzak on 12/02/2024.
//

import UIKit
import ReMVVMExt

class PBNavigationController: ReMVVMNavigationController {

    private let backButton = {
        UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }()

    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        viewControllers.last?.navigationItem.backBarButtonItem = backButton
        viewControllers.last?.navigationController?.navigationBar.prefersLargeTitles = true
        super.setViewControllers(viewControllers, animated: animated)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let viewController = self.topViewController {
            viewController.navigationItem.backBarButtonItem = backButton
        }
        super.pushViewController(viewController, animated: animated)
    }

}
