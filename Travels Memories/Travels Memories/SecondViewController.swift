//
//  SecondViewController.swift
//  Travels Memories
//
//  Created by Emircan saglam on 7.07.2022.
//

import UIKit
import CoreData


class SecondViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var feelField: UITextField!
    
    let context = appDelegate.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround() 
        
        imageView.image = UIImage(named: "click-image")
        
        //        recognizer
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
    }
    override func viewWillAppear(_ animated: Bool) {
        imageView.image = UIImage(named: "click-image")
        placeField.text = ""
        dateField.text = ""
        feelField.text = ""
    }
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        let newData = NSEntityDescription.insertNewObject(forEntityName: "BigData", into: context)
        
        newData.setValue(placeField.text!, forKey: "place")
        newData.setValue(feelField.text!, forKey: "feel")
        newData.setValue(dateField.text!, forKey: "date")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        newData.setValue(data, forKey: "image")
        
        do{
            try context.save()
            
            
            let alertController = UIAlertController(title: "Success", message: "Saved! Back to home page please", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)

        }catch {
            print("error")
        }
        
        
        
    }
    

    

}
