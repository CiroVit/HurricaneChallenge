//
//  ViewController.swift
//  VideoCall
//
//  Created by Ciro Vitale on 05/05/2020.
//  Copyright © 2020 Ciro Vitale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetUpButtons()
    }
    func SetUpButtons(){
       self.view.backgroundColor = UIColor.init(red: 3/255, green: 66/255, blue: 119/255, alpha: 1)
        Utility.filledButton(LoginButton)
        Utility.HollowButton(SignUpButton)
    }
    
}
