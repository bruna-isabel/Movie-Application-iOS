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
    
    
    @IBAction func uploadImageButton(_ sender: Any) {
        showImagePickerActionSheet()

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

extension MyAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func showImagePickerActionSheet() {
        
        let alert = UIAlertController(title: "Choose your prefered method", message: nil, preferredStyle: .actionSheet)
        
            
        alert.addAction(UIAlertAction(title: "Choose From Library", style: .default) { (action) in
            self.showImagePicker(sourceType: .photoLibrary)
        })
        
        alert.addAction(UIAlertAction(title: "Take from Camera", style: .default) { (action) in
                
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)

                let okAction = UIAlertAction(title: "Alright", style: .default, handler: { (alert: UIAlertAction!) in
                })

                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            
            } else {
                self.showImagePicker(sourceType: .camera)
            }
           
        })
        
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        //can edit image before choosing it
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Handling both types of image
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userImage.image = editedImage
        } else if let  originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImage.image = originalImage
        dismiss(animated: true, completion: nil)
        }
    }
}
