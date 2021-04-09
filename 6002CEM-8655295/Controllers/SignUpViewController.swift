//
//  SignUpViewController.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 03/04/2021.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Checks if data is correct. If it is, returns nil. Return error if not
    func validateFields() -> String? {
        
        //Check if all fields are filled are free from whitespaces and lines
    
        if firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ==  "" || emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            
            return "Please fill in all the fields."
        }
        
        // Email Validation //
        
        //Cleans email from white spaces and lines
        let emailCleaned = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Checks if email is in the right format
        if Utilities.emailValidation(emailCleaned) == false {
            
            return "Your email is in the wrong format."
        }
        
        // Password Validation //
        
        //Cleans password fromm white spaces and lines
        let passwordCleaned = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Checks if password is in right format
        if Utilities.passwordValidation(passwordCleaned) == false {
            
            return "Your password should contain at least 8 characters, a special character and a number. Please try again"
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        //Validate fields
        let error = validateFields()
        
        //If error occurs
        if error != nil {
    
            //Show error message
            errorMessages(error!)
            
        } else {
            
            //Creates cleaned versions of data
            let firstName = firstNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
            
            // Creates User //
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
                //Check if there was error in user implementation
                if err != nil {
                    //Shows error messages
                    self.errorMessages("Error creating user")
                
                } else {
                
                    // Stores User //
                
                    //Our database
                    let db = Firestore.firestore()
                    
                    //Stores firstname and last name of user
                    db.collection("users").addDocument(data: ["firstname": firstName, "lastname": lastName, "uid": result!.user.uid ]) { (error) in
                        
                        //If error occurs
                        if error != nil {
                        
                        //Shows error message for now
                        self.errorMessages("ERROR SAVING USER DATA")
                        
                        }
                    }

                    //Moves to Home screen
                    //self.transitionToHome()
                }
            }
        }
    }
    
    func errorMessages(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
        self.view.window?.rootViewController = viewController
        self.view.window?.makeKeyAndVisible()
    }

}
