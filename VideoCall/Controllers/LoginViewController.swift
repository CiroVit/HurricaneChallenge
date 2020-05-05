//
//  LoginViewController.swift
//  VideoCall
//
//  Created by Ciro Vitale on 05/05/2020.
//  Copyright © 2020 Ciro Vitale. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailTF: UITextField!
    
    @IBOutlet weak var PasswordTF: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func Validate() -> String? {
    
    if EmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        PasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        return "please fill all the fields"
    }
        let cleanedPassword = PasswordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utility.PasswordValidation(cleanedPassword) == false {
            return "Password have to contain at minimum 8 character, a special character and a number."
        }
        
        return nil
    }
    func ShowError(_ message:String){
           ErrorLabel.text = message
           ErrorLabel.alpha = 1
       }
    
    
    @IBAction func LoginTapped(_ sender: Any) {
                let error = Validate()
                
                if error != nil {
        //            show error message
                   ShowError(error!)
                }else {

//        clear email and pass
        let email = EmailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = PasswordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.ShowError("Wrong email or password")
            }else {
                
            }
        }
        
        
    }
    
    }

}
