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
    
    @IBOutlet weak var pickerTF: UITextField!
    
    @IBOutlet weak var imputTF: UILabel!
    
    var ChosedRole : String?
    
    var Roles = ["Exhibitor","visitor"]

    override func viewDidLoad() {
        super.viewDidLoad()
   // Do any additional setup after loading the view.
        createPickerView()
        dismissPickerView()
    }
    
//    Check and validate user data
    func Validate() -> String? {
        
        if NameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            SurnameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            pickerTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
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
  
    func userTransitionToHome() {
        let userHomeViewController =
            storyboard?.instantiateViewController(identifier: Storyboards.Storyboard.UserHomeViewController) as? UserHomeViewController
        
        view.window?.rootViewController = userHomeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func exhibitorTransitionToHome() {
         let exhibitorHomeViewController = storyboard?.instantiateViewController(identifier: Storyboards.Storyboard.ExhibitorHomeViewController) as? ExhibitorHomeViewController
        
        view.window?.rootViewController = exhibitorHomeViewController
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
            let role = pickerTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //        create user in DB
            Auth.auth().createUser(withEmail: email , password: password) { (result, err) in
                
                if err != nil {
                    self.ShowError("error creating user")
                }else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name" : Name, "role" : role, "surname" : surname , "uid" : result!.user.uid]) { (error) in
                        if error != nil {
                            self.ShowError("error saving user data")
                        }
                    }
//                 transition in home screen
                
        
                }
            }
            
        }
        
    }
    
}

extension SignUpViewController : UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Roles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Roles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         ChosedRole = Roles[row]
        pickerTF.text = ChosedRole
    }
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        pickerTF.inputView = pickerView
    }
    func dismissPickerView(){
         let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let done = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(self.dissmissKeyboard))
        toolBar.setItems([done], animated: false)
        toolBar.isUserInteractionEnabled = true
        pickerTF.inputAccessoryView = toolBar
    }
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
}
