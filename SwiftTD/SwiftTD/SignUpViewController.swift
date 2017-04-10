//
//  SignUpViewController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 3/5/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var submitButton: SwiftTDButton!
    @IBOutlet weak var passwordText: SwiftTDTextField!
    @IBOutlet weak var userNameText: SwiftTDTextField!
    @IBOutlet weak var confirmPasswordText: SwiftTDTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BACKGROUND_COLOR

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func fireBaseCreateAccount(_ sender: AnyObject) {
        
        if (userNameText.text == "") {
            let alert = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            
            present(alert, animated: true, completion: nil)
            
        } else {
            FIRAuth.auth()?.createUser(withEmail: userNameText.text!, password: passwordText.text!) { (user, error) in
                
                if (error == nil) {
                    
                    let loadedViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuNav")
                    self.present(loadedViewController!, animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(defaultAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}
