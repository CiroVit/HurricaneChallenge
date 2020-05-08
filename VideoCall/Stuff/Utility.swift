//
//  Utility.swift
//  VideoCall
//
//  Created by Ciro Vitale on 05/05/2020.
//  Copyright © 2020 Ciro Vitale. All rights reserved.
//

import UIKit

class Utility: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    static func TextFields(_ textfield:UITextField){
        textfield.layer.cornerRadius = 25.0
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 25.0
        textfield.textColor = UIColor.init(red: 245/255, green: 101/255, blue: 6/255, alpha: 1.0) 
    }
    
    static func filledButton(_ button:UIButton) {
        button.backgroundColor = UIColor.init(red: 245/255, green: 101/255, blue: 6/255, alpha: 1.0)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func HollowButton(_ button:UIButton){
        button.backgroundColor = .white
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 245/255, green: 101/255, blue: 6/255, alpha: 1.0)
    }
    
    
    
    
    static func PasswordValidation(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
}
}
