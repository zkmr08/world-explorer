//
//  ViewController.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 27/09/23.
//

import UIKit

final class WECountryTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let countryVC = WECountryViewController()
        let countryLangVC = WESearchViewController(config: WESearchViewController.Config(type: .searchByLang))
        let countryRegionVC = WESearchViewController(config: WESearchViewController.Config(type: .searchByRegion))
        
        countryVC.title = "Countries"
        countryLangVC.title = "Search By Language"
        countryRegionVC.title = "Search by Region"
        
        countryVC.navigationItem.largeTitleDisplayMode = .automatic
        countryLangVC.navigationItem.largeTitleDisplayMode = .automatic
        countryRegionVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: countryVC)
        let nav2 = UINavigationController(rootViewController: countryLangVC)
        let nav3 = UINavigationController(rootViewController: countryRegionVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Countries", image: UIImage(systemName: "globe"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search by Language", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Search by Region", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 3)
        
        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
