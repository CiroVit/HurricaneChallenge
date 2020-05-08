//
//  SignUpViewController.swift
//  VideoCall
//
//  Created by Ciro Vitale on 05/05/2020.
//  Copyright © 2020 Ciro Vitale. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase


class SignUpViewController: UIViewController {

    @IBOutlet weak var NameTF: UITextField!
    
    @IBOutlet weak var SurnameTF: UITextField!
    
    @IBOutlet weak var EmailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var SignUPButton: UIButton!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBOutlet weak var imputTF: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
   // Do any additional setup after loading the view.
        SetUpButtons()
    }
    
    func SetUpButtons() {
        self.view.backgroundColor = UIColor.init(red: 3/255, green: 66/255, blue: 119/255, alpha: 1)
        Utility.filledButton(SignUPButton)
        Utility.TextFields(NameTF)
        Utility.TextFields(SurnameTF)
        Utility.TextFields(EmailTF)
        Utility.TextFields(passwordTF)
    }
    
//    Check and validate user data
    func Validate() -> String? {
        
        if NameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            SurnameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
                {
            return "please fill all the fields"
        }
        
        let cleanedPassword = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utility.PasswordValidation(cleanedPassword) == false {
            return "Password have to contain at minimum 8 character, a special character and a number."
        }
        
        return nil
    }
    func ShowError(_ message:String){
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
  
    func TransitionToHome() {
        let userHomeViewController =
            storyboard?.instantiateViewController(identifier: Storyboards.Storyboard.ExhibitorHomeViewController) as? ExhibitorHomeViewController
        
        view.window?.rootViewController = userHomeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func SignUpTapped(_ sender: Any) {
//        validate
        let error = Validate()
        
        if error != nil {
//            show error message
           ShowError(error!)
        }else {
//            clean data
            let Name = NameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let surname = SurnameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //        create user in DB
            Auth.auth().createUser(withEmail: email , password: password) { (result, err) in
                
                if err != nil {
                    self.ShowError("error creating user")
                }else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name" : Name, "surname" : surname , "uid" : result!.user.uid]) { (error) in
                        if error != nil {
                            self.ShowError("error saving user data")
                        }
                    }
//                 transition in home screen
                    
                    self.TransitionToHome()
                        
                    
                }
            }
            
        }
        
    }
    
}
