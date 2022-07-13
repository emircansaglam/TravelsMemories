//
//  DetailViewController.swift
//  Travels Memories
//
//  Created by Emircan saglam on 11.07.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var detailData : BigData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround() 
        textView.isUserInteractionEnabled = false
        
        imageView.image = UIImage(data: (detailData?.image)!)
        placeLabel.text = detailData?.place
        dateLabel.text = detailData?.date
        textView.text = detailData?.feel
        
        
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
