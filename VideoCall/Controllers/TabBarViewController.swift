//
//  TabBarViewController.swift
//  VideoCall
//
//  Created by Ciro Vitale on 08/05/2020.
//  Copyright © 2020 Ciro Vitale. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class TabBarViewController: UITabBarController,UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBar.appearance().tintColor = UIColor.init(red: 245/255, green: 101/255, blue: 6/255, alpha: 1.0)
        addCustomTabBar()
        hideTabBorder()
        
    }
//    check users logged in

    let CustomTabBar: UIView =  {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 17
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
        view.layer.shadowRadius = 10.0
        view.layer.shadowOpacity = 0.12
        
        return view
    }()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CustomTabBar.frame = tabBar.frame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var newSafeArea = UIEdgeInsets()
        
        newSafeArea.bottom += CustomTabBar.bounds.size.height
        self.children.forEach({$0.additionalSafeAreaInsets = newSafeArea})
    }
    
    private func addCustomTabBar() {
        CustomTabBar.frame = tabBar.frame
        view.addSubview(CustomTabBar)
        view.bringSubviewToFront(self.tabBar)
    }
    
    func hideTabBorder() {
        let tabBar = self.tabBar
        tabBar.backgroundImage = UIImage.from(color: .clear)
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true
    }
    func TransitionToHome() {
        let userHomeViewController =
            storyboard?.instantiateViewController(identifier: Storyboards.Storyboard.ViewController) as? ViewController
        
        view.window?.rootViewController = userHomeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    
}
extension UIImage {
    static func from(color: UIColor) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
