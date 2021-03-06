//
//  ViewController.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 16/03/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emailField.layer.cornerRadius = 22
        passwordField.layer.cornerRadius = 22
        loginButton.layer.cornerRadius = 22
       
    }
    
    func validateFields() -> String? {
        
        if emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            self.errorLabel.isHidden = false
            return "Please fill in all the fields."
        }
        
        return nil
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        // Validate text fields //
        let error = validateFields()
        
        //If error occurs
        if error != nil {
    
            //Show error message
            self.errorLabel.isHidden = false
            errorMessages(error!)
            
        } else {
            
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Signs in the user //
            Auth.auth().signIn(withEmail: email, password: password) {
                (result, error) in
                
                if error != nil {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                    
                } else {
                    
                    print("User successfully logged in")
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
                    self.view.window?.rootViewController = viewController
                    self.view.window?.makeKeyAndVisible()
                    self.dismiss(animated: false, completion: nil)
                }
            }
            
        }
    }
    
    func errorMessages(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    

    
}


