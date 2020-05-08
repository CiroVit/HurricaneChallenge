//
//  SettingsViewController.swift
//  VideoCall
//
//  Created by Ciro Vitale on 08/05/2020.
//  Copyright © 2020 Ciro Vitale. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController {
    @IBOutlet weak var LogOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 3/255, green: 66/255, blue: 119/255, alpha: 1)
      setUpButton()

        // Do any additional setup after loading the view.
    }
    
    func TransitionToHome() {
        let userHomeViewController =
            storyboard?.instantiateViewController(identifier: Storyboards.Storyboard.ViewController) as? ViewController
        
        view.window?.rootViewController = userHomeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    func setUpButton(){
        Utility.filledButton(LogOutButton)
    }

    @IBAction func LogOutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
                  self.TransitionToHome()
            
                  } catch {
                      print(error.localizedDescription)
                  }

           }
        
    }

