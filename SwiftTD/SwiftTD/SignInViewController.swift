//
//  SignInViewController.swift
//  SwiftTD
//
//  Created by Taylor Cargill on 3/5/17.
//  Copyright © 2017 Taylor Cargill. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

var currentUser: String!

class SignInViewController: UIViewController {

    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var passWordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    
    
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
    
    @IBAction func fireBaseLogin(_ sender: AnyObject) {
        
        userNameField.text = "test5@gmail.com"
        passWordField.text = "abcd1234"
        
        if (self.userNameField.text == "" || self.passWordField.text == "") {
            
            let alert = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(defaultAction)
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.userNameField.text!, password: self.passWordField.text!) { (user, error) in
                
                if (error == nil) {
                    let loadedViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuNav")
                    //print(FIRAuth.auth()?.currentUser?.displayName)
                    //print(FIRAuth.auth()?.currentUser?.email)
                    currentUser = FIRAuth.auth()?.currentUser?.displayName
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
