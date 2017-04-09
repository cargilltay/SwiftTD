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

//need this here for some reason

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
    
    @IBAction func loginAction(_ sender: AnyObject) {
        
        userNameField.text = "test@gmail.com"
        passWordField.text = "abcd1234"
        
        if self.userNameField.text == "" || self.passWordField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.userNameField.text!, password: self.passWordField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the MainNav if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainMenuNav")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

}
