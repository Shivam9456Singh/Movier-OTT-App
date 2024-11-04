//  ViewController.swift
//  Movier
//
//  Created by Shivam Kumar on 14/08/24.
//

import UIKit

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "tray.and.arrow.down")
        
        vc1.title = "Home"
        vc2.title = "Upcoming"
        vc3.title = "Search"
        vc4.title = "Downloads"
        
        view.tintColor = .systemRed
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        guard let tabBarItemView = viewController.tabBarItem.value(forKey: "view") as? UIView else{
            return
        }
        
        UIView.animate(withDuration: 0.15, animations: {
            tabBarItemView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) {
            _ in
            UIView.animate(withDuration: 0.15, animations: {
                tabBarItemView.transform = CGAffineTransform.identity
            })
        }
    }
   
}



