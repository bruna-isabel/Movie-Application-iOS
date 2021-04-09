//
//  MyAccountViewController.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 08/04/2021.
//

import UIKit
import FirebaseAuth


class MyAccountViewController: UIViewController {

    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var saveDetailsButton: UIButton!
    @IBOutlet var logoutButton: UIButton!
    
    var window: UIWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveDetailsTapped(_ sender: Any) {
        //Saves Image in DB
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        //User is logged out
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                logoutUser()
            }
            catch {
                print("Cant logout user")
            }
        }
    }
    
    func logoutUser() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "initialViewController") as! InitialViewController
        self.view.window!.rootViewController = controller
        self.view.window?.makeKeyAndVisible()
        
        }
}
