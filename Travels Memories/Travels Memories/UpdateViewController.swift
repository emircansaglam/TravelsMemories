//
//  UpdateViewController.swift
//  Travels Memories
//
//  Created by Emircan saglam on 10.07.2022.
//

import UIKit

class UpdateViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var feelTextField: UITextField!
    
    var updateData : BigData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        imageView.image = UIImage(data: (updateData?.image!)!)
        placeTextField.text = updateData?.place
        dateTextField.text = updateData?.date
        feelTextField.text = updateData?.feel
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectedImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func selectedImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
        if let u = updateData  {
            let data = imageView.image?.jpegData(compressionQuality: 0.5)
            u.image = data
            u.date = dateTextField.text
            u.place = placeTextField.text
            u.feel = feelTextField.text
            
            appDelegate.saveContext()
            self.dismiss(animated: true, completion: nil)
        }
    }
   
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
