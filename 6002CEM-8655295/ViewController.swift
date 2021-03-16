//
//  ViewController.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 16/03/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var SignInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        usernameTextField.layer.cornerRadius = 22
        PasswordTextField.layer.cornerRadius = 22
        SignInButton.layer.cornerRadius = 22
        
    }


}

