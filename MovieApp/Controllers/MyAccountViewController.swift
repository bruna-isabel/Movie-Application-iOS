//
//  MyAccountViewController.swift
//  6002CEM-8655295
//
//  Created by Bruna Coimbra on 08/04/2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseDatabase


class MyAccountViewController: UIViewController {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var saveDetailsButton: UIButton!
    @IBOutlet var logoutButton: UIButton!
    
    var window: UIWindow!
    var urlPic: String = ""
    
    //variables
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser?.uid == nil {
            logoutUser()
                }
        let urlImage = urlPic
        self.downloadImage(from: urlImage)
    }
    
    @IBAction func uploadImageButton(_ sender: Any) {
        showImagePickerActionSheet()

    }
    @IBAction func saveDetailsTapped(_ sender: Any) {
        saveChanges()
        
        let alertController = UIAlertController(title: nil, message: "Photo was successfully updated!", preferredStyle: .alert)

        let understoodAction = UIAlertAction(title: "Understood!", style: .default, handler: { (alert: UIAlertAction!) in
        })
        alertController.addAction(understoodAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        //User is logged out
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                logoutUser()
            }
            catch {
                print("Can't logout user")
            }
        }
    }
    
    
    // Logouts User //
    
    func logoutUser() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "LoginNavigationController") as! UINavigationController
        self.view.window!.rootViewController = controller
        self.view.window?.makeKeyAndVisible()
        
        }
    
    // Uploading Images to Firebase //
    // Returns url string to image
    func uploadUserImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->()) ) {
        
        //checks if user is currently authenticated
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        //reference to each users id storage
        let storageRef = Storage.storage().reference().child("profile_images/\(uid)/\(image)")
        print(storageRef)
        
        //turns UIImage into jpeg
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        
        //defines metadata
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        //downloads url
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            
            if error == nil || metaData != nil {
                storageRef.downloadURL { (url, error) in
                    guard let url = url , error == nil else {
                        return
                    }
                    
                    let urlString = url.absoluteString
                    print("Download Url: \(urlString)")
                    
                    //saves profileimageurl
                    self.saveProfile(profileImageURL: urlString)
                    self.urlPic = urlString
                }
            }
        }
    }
    
    // Saves user profile into Firebase
    func saveProfile(profileImageURL: String) {
        
        let uid = Auth.auth().currentUser?.uid
        var docID = ""
        
        //Get to document id first
        db.collection("users").whereField("uid", isEqualTo: uid!).getDocuments(completion: {  (documentSnapshot, error) in
            if let error = error {
                
                print("Error getting documents: \(error)")
                
            } else {
                
                for document in documentSnapshot!.documents  {
                    docID = (documentSnapshot?.documents[0].documentID)!
                    print("DocID: \(docID)")
                    //Updates profile image in firebase database
                    self.db.collection("users").document(docID).updateData(["profile_image": profileImageURL]) { (error) in
                        
                        //If error occurs
                        if error != nil {
                        
                        //Shows error message for now
                            print("ERROR UPDATING PROFILE IMAGE:  \(String(describing: error?.localizedDescription))")
                            return
                        }
                        
                        print("Photo successfully updated")
                        }

                    }
              
                
            }
        })
    }
    
    func saveChanges() {
        
        //Saves Image in DB
        guard let image = userImage.image else {return}
        userImage.image = image
        
        self.uploadUserImage(image) { url in
            if url != nil {
                print( "image Successfully upload to firebase")
            } else {
            // Error unable to upload profile image
                print("Unable to upload profile pic.")
            }
        }
    }

    
        func downloadImage(from url: String) {
            
            guard let imageURL = URL(string: url) else { return }
            print(imageURL)

            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else { return }

                let image = UIImage(data: imageData)
                print(imageURL)
                
                DispatchQueue.main.async {
                    self.userImage.image = image
                }
            }
        
                
    }
}



extension MyAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerActionSheet() {
        
        //Action Sheet
        let alert = UIAlertController(title: "Choose your prefered method", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Choose From Library", style: .default) { (action) in
            self.showImagePicker(sourceType: .photoLibrary)
        })
        
        alert.addAction(UIAlertAction(title: "Take from Camera", style: .default) { (action) in
                
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)

                let okAction = UIAlertAction(title: "Understood!", style: .default, handler: { (alert: UIAlertAction!) in
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
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
