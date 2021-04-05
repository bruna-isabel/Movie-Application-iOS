//
//  ViewController.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 16/03/2021.
//

import UIKit

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
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  let tabBarVC = segue.destination as
    //}


}

