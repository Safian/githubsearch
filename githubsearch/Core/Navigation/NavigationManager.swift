//
//  NavigationManager.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import UIKit

class NavigationManager {

    func navigateToRepositoryDetail(with urlString: String, navigationController: UINavigationController?) {
        if let viewController = RepositoryDetailsViewController.createViewController(urlString) {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
